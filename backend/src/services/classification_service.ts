export function classifyTask(title: string, description = '') {
  const text = `${title} ${description}`.toLowerCase();

  let category: 'scheduling' | 'finance' | 'technical' | 'safety' | 'general' =
    'general';

  if (/(meeting|schedule|call|appointment|deadline)/i.test(text)) {
    category = 'scheduling';
  } else if (/(payment|invoice|bill|budget|cost|expense)/i.test(text)) {
    category = 'finance';
  } else if (/(bug|fix|error|install|repair|maintain)/i.test(text)) {
    category = 'technical';
  } else if (/(safety|hazard|inspection|compliance|ppe)/i.test(text)) {
    category = 'safety';
  }

  let priority: 'high' | 'medium' | 'low' = 'low';

  if (/(urgent|asap|immediately|today|critical|emergency)/i.test(text)) {
    priority = 'high';
  } else if (/(soon|this week|important)/i.test(text)) {
    priority = 'medium';
  }


  const dates: string[] = [];
  if (/(today|tomorrow|next week|monday|tuesday|wednesday|thursday|friday)/i.test(text)) {
    dates.push(
      ...(text.match(
        /(today|tomorrow|next week|monday|tuesday|wednesday|thursday|friday)/gi
      ) || [])
    );
  }

  const people =
    text.match(/(?:with|by|assign to)\s+([a-zA-Z\s]+)/gi)?.map(s =>
      s.replace(/(with|by|assign to)/i, '').trim()
    ) || [];

  const locations =
    text.match(/(?:at|in)\s+([a-zA-Z\s]+)/gi)?.map(s =>
      s.replace(/(at|in)/i, '').trim()
    ) || [];

  const actions =
    text.match(
      /\b(schedule|pay|fix|inspect|review|submit|install|call|email|prepare)\b/gi
    ) || [];

  const suggestedActionsMap: Record<string, string[]> = {
    scheduling: [
      'Block calendar',
      'Send invite',
      'Prepare agenda',
      'Set reminder',
    ],
    finance: [
      'Check budget',
      'Get approval',
      'Generate invoice',
      'Update records',
    ],
    technical: [
      'Diagnose issue',
      'Check resources',
      'Assign technician',
      'Document fix',
    ],
    safety: [
      'Conduct inspection',
      'File report',
      'Notify supervisor',
      'Update checklist',
    ],
    general: [],
  };

  return {
    category,
    priority,
    extracted_entities: {
      dates,
      people,
      locations,
      actions,
    },
    suggested_actions: suggestedActionsMap[category] || [],
  };
}

