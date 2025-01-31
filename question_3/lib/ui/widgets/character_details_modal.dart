import 'package:flutter/material.dart';
import 'package:question_3/models/character_model.dart';

class CharacterDetailsModal extends StatelessWidget {
  final CharacterModel character;
  final ScrollController? scrollController;

  const CharacterDetailsModal({
    super.key,
    required this.character,
    this.scrollController,
  });

  static Future<void> show(BuildContext context, CharacterModel character) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 1,
        minChildSize: 0.5,
        maxChildSize: 1,
        expand: false,
        builder: (context, scrollController) => CharacterDetailsModal(
          character: character,
          scrollController: scrollController,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            CharacterImage(character: character),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildTitle(context),
                  const SizedBox(height: 16),
                  _buildBasicInfo(context),
                  _buildLocationInfo(context),
                  _buildEpisodesInfo(context),
                  InfoRow(
                    label: 'Created',
                    value: _formatDate(character.created),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.close,
          color: theme.iconTheme.color,
          size: 30,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      character.name ?? '',
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildBasicInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoRow(label: 'Status', value: character.status ?? ''),
        InfoRow(label: 'Species', value: character.species ?? ''),
        if (character.type?.isNotEmpty ?? false)
          InfoRow(label: 'Type', value: character.type ?? ''),
        InfoRow(label: 'Gender', value: character.gender ?? ''),
      ],
    );
  }

  Widget _buildLocationInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CharacterInfoSection(
          title: 'Origin',
          content: InfoRow(
            label: 'Location',
            value: character.origin?.name ?? '',
          ),
        ),
        CharacterInfoSection(
          title: 'Current Location',
          content: InfoRow(
            label: 'Location',
            value: character.location?.name ?? '',
          ),
        ),
      ],
    );
  }

  Widget _buildEpisodesInfo(BuildContext context) {
    return CharacterInfoSection(
      title: 'Episodes',
      content: Text(
        '${character.episode?.length ?? 0} episodes',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day}/${date.month}/${date.year}';
  }
}

class CharacterImage extends StatelessWidget {
  final CharacterModel character;

  const CharacterImage({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Hero(
        tag: 'character_${character.id}',
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            image: DecorationImage(
              image: NetworkImage(character.image ?? ''),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class CharacterInfoSection extends StatelessWidget {
  final String title;
  final Widget content;

  const CharacterInfoSection({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          content,
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: theme.textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
