// router.get('/', async (req, res) => {
//   const {
//     status,
//     category,
//     priority,
//     limit = '10',
//     offset = '0'
//   } = req.query as Record<string, string>;

//   let query = supabase
//     .from('tasks')
//     .select('*')
//     .order('created_at', { ascending: false });

//   if (status) query = query.eq('status', status);
//   if (category) query = query.eq('category', category);
//   if (priority) query = query.eq('priority', priority);

//   query = query.range(
//     Number(offset),
//     Number(offset) + Number(limit) - 1
//   );

//   const { data, error } = await query;

//   if (error) {
//     return res.status(500).json({ message: error.message });
//   }

//   res.json({
//     limit: Number(limit),
//     offset: Number(offset),
//     count: data.length,
//     data
//   });
// });
