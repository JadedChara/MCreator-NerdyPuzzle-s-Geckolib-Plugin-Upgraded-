<#--
 # MCreator (https://mcreator.net/)
 # Copyright (C) 2012-2020, Pylo
 # Copyright (C) 2020-2021, Pylo, opensource contributors
 # Copyright (C) 2020-2022, Goldorion, opensource contributors
 #
 # This program is free software: you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.
 #
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <https://www.gnu.org/licenses/>.
 #
 # Additional permission for code generator templates (*.ftl files)
 #
 # As a special exception, you may create a larger work that contains part or
 # all of the MCreator code generator templates (*.ftl files) and distribute
 # that work under terms of your choice, so long as that work isn't itself a
 # template for code generation. Alternatively, if you modify or redistribute
 # the template itself, you may (at your option) remove this special exception,
 # which will cause the template and the resulting code generator output files
 # to be licensed under the GNU General Public License without this special
 # exception.
-->

<#-- @formatter:off -->
<#include "../procedures.java.ftl">
<#include "../mcitems.ftl">

package ${package}.world.features.ores;

public class ${name}Feature extends OreFeature {

	public static ${name}Feature FEATURE = null;
		public static Holder<ConfiguredFeature<OreConfiguration, ?>> CONFIGURED_FEATURE = null;
		public static Holder<PlacedFeature> PLACED_FEATURE = null;

		public static Feature<?> feature() {
			FEATURE = new ${name}Feature();
			CONFIGURED_FEATURE = FeatureUtils.register("${modid}:${registryname}", FEATURE,
					new OreConfiguration(${name}FeatureRuleTest.INSTANCE, ${JavaModName}Blocks.${data.getModElement().getRegistryNameUpper()}.defaultBlockState(), ${data.frequencyOnChunk})
			);
			PLACED_FEATURE = PlacementUtils.register("${modid}:${registryname}", CONFIGURED_FEATURE, List.of(
					CountPlacement.of(${data.frequencyPerChunks}), InSquarePlacement.spread(),
					HeightRangePlacement.${data.generationShape?lower_case}(VerticalAnchor.absolute(${data.minGenerateHeight}), VerticalAnchor.absolute(${data.maxGenerateHeight})),
					BiomeFilter.biome()
			));
			return FEATURE;
		}

	public static final Predicate<BiomeSelectionContext> GENERATE_BIOMES = BiomeSelectors.
		<#if data.restrictionBiomes?has_content>
			includeByKey(
				<#list data.restrictionBiomes as restrictionBiome>
					ResourceKey.create(Registry.BIOME_REGISTRY, new ResourceLocation("${restrictionBiome}"))<#if restrictionBiome?has_next>,</#if>
				</#list>
			)
		<#else>
		   all()
		</#if>;

	public ${name}Feature() {
		super(OreConfiguration.CODEC);
	}

	public boolean place(FeaturePlaceContext<OreConfiguration> context) {
		WorldGenLevel world = context.level();
		ResourceKey<Level> dimensionType = world.getLevel().dimension();
		boolean dimensionCriteria = false;

		<#list data.spawnWorldTypes as worldType>
			<#if worldType=="Surface">
				if(dimensionType == Level.OVERWORLD)
					dimensionCriteria = true;
			<#elseif worldType=="Nether">
				if(dimensionType == Level.NETHER)
					dimensionCriteria = true;
			<#elseif worldType=="End">
				if(dimensionType == Level.END)
					dimensionCriteria = true;
			<#else>
				if(dimensionType == ResourceKey.create(Registry.DIMENSION_REGISTRY,
						new ResourceLocation("${generator.getResourceLocationForModElement(worldType.toString().replace("CUSTOM:", ""))}")))
					dimensionCriteria = true;
			</#if>
		</#list>

		if(!dimensionCriteria)
			return false;

		<#if hasProcedure(data.generateCondition)>
		int x = context.origin().getX();
		int y = context.origin().getY();
		int z = context.origin().getZ();
		if (!<@procedureOBJToConditionCode data.generateCondition/>)
			return false;
		</#if>

		return super.place(context);
	}

	private static class ${name}FeatureRuleTest extends RuleTest {

		static final ${name}FeatureRuleTest INSTANCE = new ${name}FeatureRuleTest();
		static final com.mojang.serialization.Codec<${name}FeatureRuleTest> codec = com.mojang.serialization.Codec.unit(() -> INSTANCE);

		static final RuleTestType<${name}FeatureRuleTest> CUSTOM_MATCH = Registry.register(Registry.RULE_TEST,
				new ResourceLocation("${modid}:${registryname}_match"), () -> codec);

		public boolean test(BlockState blockAt, RandomSource random) {
			boolean blockCriteria = false;

			<#list data.blocksToReplace as replacementBlock>
				if(blockAt.getBlock() == ${mappedBlockToBlock(replacementBlock)})
					blockCriteria = true;
			</#list>

			return blockCriteria;
		}

		protected RuleTestType<?> getType() {
			return CUSTOM_MATCH;
		}

	}

}

<#-- @formatter:on -->