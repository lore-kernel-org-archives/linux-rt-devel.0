Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392C01F03C2
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044450; cv=fail; b=I9AY466/LJUnLc7CRx8YjMuTG23Ux1pJbwMGcq90YRCGrAT6nVycQYEKVKUMs3tdD2mK/vQpoejrhsQ5Io/2jM6CkGjsuoK8wvS93k9A+APM5POShf0c5HvPni53QtWgQ2iAUspIMVs8YTOO7cEZaQwFzZQIibPyXQSxIzEDWmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044450; c=relaxed/simple;
	bh=+mXG5MujdqBeiUXgOLCAQbqFT+uMKDK4kY1LFAgTEug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPw/mtOJ7V4KzYJIU/H07terqOqVKuUEGuKOVUo2aSMaLIhNqg/InKuaf+xh7CviNtlf0h0CkcVEdq6vUQW5sC5sDU3u/BnxPGt8ZCAqTZ3beDHHNPYNdB55QI11NXB+pGwZ8Uc9/nFlFBJ0pSKy/G35lA+5wBiejKm6XC8bLFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qh2AcYXJ; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qh2AcYXJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=caK0HXsaaQX2ah9VL6EQeyfeUPv+o18GiyLDgaE15XivP/eoHG2pwv7+4T7CyWRjdQBCiFY8z/gKvbKDhjRF9OaFKgJYZjf5H1zSfiG8eeYd8p1yNnjOfThzWF8tB+gkUjZQ/YPhRlmi7jJZauewASsGWCpjujaWahTVb8ZqIBHATKkZ5OOxjluy/YIPkPWhmjAEqTZipqs8q0CJ+D3MDZzH0pEYQC3Aofh+5pXlzgu1aTOmjbk7Q9MSCDbcmgrk2kChv+YnPp8yuRuNf+MynxsfIwYSOyf1NbD6758LYM2fk2jdKQPotKzmlwefUWlryS9XSML9vU0rntVGeYbnWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uj5KCx9jgyfW3Aj/ZNL+dU8cihzFhF3M/F05npibLf8=;
 b=OGHaLb40EAwVzVfe6UC3dJMpj7fvjdNhZtR3cczDdQls7tLpQvfamGNEddvCbrXbT2yyYEYxFmi15fndy3KVkuFWRPlePZTNbB3mkjSH+FDFL9G1dxF+a737XoNzSyrWJTknGvbR7hU4ndHSL7nsTyxgTznn/0awxIC/q8O9tk/vANS+FM1ITWW2tDZTsWHilwUa/+1P4VhsQpNkOxnYDaz6ZQG8TB233H8YhHVlJLp3IesVCb+q5lupgr4AYWN2K5GBz9W+Og+AMMAO7W/EcFJ4HjAOtiwIYWHt24M6QLEnVjvLcezqkS/mTUZxiUO9cdCQfFhTeMPPj/bSOP97jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uj5KCx9jgyfW3Aj/ZNL+dU8cihzFhF3M/F05npibLf8=;
 b=Qh2AcYXJaqLwYfpY61ymx+Efv1KqhK4cUcEsIzKbA5JCcmVAb08cL68tFWzVkLq1cqophLNFRQSWNFJc7cv/rGkMbudAmbOZ2kAEHmQRGcclAQ3rqU0b9S1EwvVQm1YZ0VQlMkKkoFd35/LVPzIiBpQE8+p4Lz2AwOGlqoJ73Nk=
Received: from MN2PR08CA0024.namprd08.prod.outlook.com (2603:10b6:208:239::29)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.24; Thu, 20 Feb
 2025 09:40:44 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:208:239:cafe::fe) by MN2PR08CA0024.outlook.office365.com
 (2603:10b6:208:239::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.20 via Frontend Transport; Thu,
 20 Feb 2025 09:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 09:40:44 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 03:40:36 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Valentin Schneider <vschneid@redhat.com>, "Ben
 Segall" <bsegall@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Andy
 Lutomirski" <luto@kernel.org>, <linux-kernel@vger.kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, "Sebastian Andrzej
 Siewior" <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
	<linux-rt-devel@lists.linux.dev>, Tejun Heo <tj@kernel.org>, "Frederic
 Weisbecker" <frederic@kernel.org>, Barret Rhoden <brho@google.com>, "Petr
 Mladek" <pmladek@suse.com>, Josh Don <joshdon@google.com>, Qais Yousef
	<qyousef@layalina.io>, "Paul E. McKenney" <paulmck@kernel.org>, David Vernet
	<dvernet@meta.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: [RFC PATCH 21/22] [MAYBE BUGFIX] sched/fair: Group all the se->min_* members together for propagation
Date: Thu, 20 Feb 2025 09:32:56 +0000
Message-ID: <20250220093257.9380-22-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220093257.9380-1-kprateek.nayak@amd.com>
References: <20250220093257.9380-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 3555af5c-c788-42cc-e00a-08dd5192a5a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tMS7d9sFJyJ0IUxPJA3iiYOFunEqAiZmEzog742MCb4hwEcQXOM68iOPmg9W?=
 =?us-ascii?Q?Iw/I/BZ0ljujcEtYTmx3KxsvO/2e42/N8+vas6U5AMSDUtRGMtNGNdSDUiDq?=
 =?us-ascii?Q?bdgyR5aGVYTalaMFtHN5KfzqIu3fqYGn+ZjT/4trTBGWrwuhoylvpxda+RcZ?=
 =?us-ascii?Q?IlOZgXIvAFduqo6/6bjcnP/U+FSxT0Tou0yhELs/gL2nYIHqifcaGbdxYzo7?=
 =?us-ascii?Q?VhLwf5P9XCs5V/8DZ65lRPFeX0HOAv54m4RpY+YSt9UlfV3OK+9h/2lusfDw?=
 =?us-ascii?Q?20WrFoDBEZykJUpOmo1BOfn8iV1FUVFJdgVa2TokY0y/A0IRJR8m/3fu66Vc?=
 =?us-ascii?Q?PvnyGOY95VGIT37JMGi4BG0UemaotoVqrP8XwLFuwFb1GZ++wVz3n7Od3I7G?=
 =?us-ascii?Q?1eqcsNz6VLZh/oo/ZB4IOhvbbnmMOGP6oItHE9HSXGC7EMJrIP8zR/IhHYkR?=
 =?us-ascii?Q?hphsyH/0nKY440W5bhmhR1PT673vWca76P9ySC0/DEQAEhF2+NH6Ba3gSuhP?=
 =?us-ascii?Q?engjWpQX46XdE1x6NOmVhWTjY+ayfJ4NzoaT2ON7HiqxCQotcIrh8Bxj1n3+?=
 =?us-ascii?Q?l1Kmjrfpv6nV2IXX3qW0zLRjbYTYRHRisPMvNRdjaKwV2TDatWOL1GptSkOP?=
 =?us-ascii?Q?ILA4q8cc1YL25Qgd3OWCQ0LbDXtpegEa/bHsjn6dJoVwJJg7QILOmOeO6ZgC?=
 =?us-ascii?Q?y8L9OPnD4UYOBIemjttqkc6ww6wjp5hxzUh4DVev1zo6KExYIkIFgqfcJoX/?=
 =?us-ascii?Q?bckAFCmzqkq/vXib8Bwklko7OqO3O3xtaJUkW0fYCayr6db2zOLUecGM6Gpp?=
 =?us-ascii?Q?AK10rhY/940+2h3QFJpRUJeoC+RiObSbaxHnhObLoQC7lEPKymfxFpyt6Umz?=
 =?us-ascii?Q?cmcRsjKbvIUJTP5tvUoZ0ZdbIPKIVsX6qYxnUlCNKB4jPCnfR20eY86/7CLn?=
 =?us-ascii?Q?c2BoSqsm0TUqKPKIn3oBysSNV/DO6oVirhG7EpUpLS3atpzILxW9iIB+Kfxn?=
 =?us-ascii?Q?iZyhVyzveNJWFCo+KLZkb/g4x8uDaBj8X1somvdf40ovfMKr2i3KceGtVnVf?=
 =?us-ascii?Q?xy21N/e5ifh0dWPmWs00fDDPhuVLPKYnxdJXeDNdxMAYZcEvhMnR9q04z5mz?=
 =?us-ascii?Q?iG+lFMuIGqsMFAYEff0IjWGsM2N4UTPA7Xpk6MdMfliK4TKkQCtAWdyHiQnv?=
 =?us-ascii?Q?aJOa25YwvnfhZ8tZWXNeLiOr94PwE/6+tlRDZGyF3jyVhpRow6J+QpjRYbA7?=
 =?us-ascii?Q?xr0V7ZdMU3D9bF3NypALs/OZydYdy7R6q+yJU1Fc274kSptWtE6rWfQxHy/4?=
 =?us-ascii?Q?zlxnqJPTyl+MK/rIXkqgP4eL0hsI8w+T0hPxvSKjOayfWN51aAH1vNvbPZN+?=
 =?us-ascii?Q?Qnm4j94t7kT2If8+eHS7+qZWZgUSu0+OSWPi+8mKB7gKDI8uglZVoIaWz4p9?=
 =?us-ascii?Q?z7VFPGfhZplEaE3hFt6/S56KtHs6RA6MfRkjL3kLV3F0qGfBJ+8iD/Qmz9N/?=
 =?us-ascii?Q?04WD2hGNI9XvNcM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:40:44.2327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3555af5c-c788-42cc-e00a-08dd5192a5a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702

When working on the prototype, at some point, min_kcs_vruntime heap
integrity issues were encountered. Since then many bugs were ironed out
but when auditing rb_{add,erase}_augmented_cached(), it was noticed that
only "min_vruntime" was considered as RBAUGMENTED for
RB_DECLARE_CALLBACKS().

The augment->copy() function generated only copies RBAUGMENTED member.
It is very likely that augment->propagate() is always called after
augment->copy() similar to the convention in augment->rotate() which
reconstructs all of min_{vruntime,slice,kcs_vruntime} before comparing
if the values have changed however this author was not sure if
augment->propagate() indeed reaches until the copied node for Case 2.
in __rb_erase_augmented().

Group all the min_* members together that need propagation to rb_root
and pass the new "min" struct as RBAUGMENTED to ease the author's
paranoia.

XXX: Reverting this bit reintroduces the heap integrity issue. It does
not happen immediately into the run and the amount of traces are
overwhelming to analyze which series of rbtree operations lead to this
but with this patch I haven't run into the heap integrity issue so far.
The cover letter should have more details.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 include/linux/sched.h | 20 +++++++++-------
 kernel/sched/debug.c  |  2 +-
 kernel/sched/fair.c   | 54 +++++++++++++++++++++----------------------
 3 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 200cc086e121..6fd5cee3a0f5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -549,8 +549,18 @@ struct sched_entity {
 	struct load_weight		load;
 	struct rb_node			run_node;
 	u64				deadline;
-	u64				min_vruntime;
-	u64				min_slice;
+	struct {
+		u64			vruntime;
+		u64			slice;
+
+#ifdef CONFIG_FAIR_GROUP_SCHED
+		/*
+		 * min_vruntime of the kernel mode preempted
+		 * entities in the subtree of this sched entity.
+		 */
+		s64			kcs_vruntime;
+#endif
+	} min;
 
 	struct list_head		group_node;
 	unsigned char			on_rq;
@@ -601,12 +611,6 @@ struct sched_entity {
 	/* Entity picked on a throttled hierarchy */
 	unsigned char			sched_throttled;
 					/* hole */
-
-	/*
-	 * min_vruntime of the kernel mode preempted entities
-	 * in the subtree of this sched entity.
-	 */
-	s64				min_kcs_vruntime;
 #endif /* CONFIG_CFS_BANDWIDTH */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index ef047add7f9e..37bca53f109f 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -821,7 +821,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	raw_spin_rq_lock_irqsave(rq, flags);
 	root = __pick_root_entity(cfs_rq);
 	if (root)
-		left_vruntime = root->min_vruntime;
+		left_vruntime = root->min.vruntime;
 	first = __pick_first_entity(cfs_rq);
 	if (first)
 		left_deadline = first->deadline;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 39c7e8f548ca..97566a043398 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -768,7 +768,7 @@ int pick_subtree(struct cfs_rq *cfs_rq, struct sched_entity *se, bool h_throttle
 	if (unlikely(h_throttled))
 		return pick_subtree_on_throttled(cfs_rq, se);
 
-	return vruntime_eligible(cfs_rq, se->min_vruntime);
+	return vruntime_eligible(cfs_rq, se->min.vruntime);
 }
 
 static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
@@ -800,9 +800,9 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 
 	if (se) {
 		if (!curr)
-			vruntime = se->min_vruntime;
+			vruntime = se->min.vruntime;
 		else
-			vruntime = min_vruntime(vruntime, se->min_vruntime);
+			vruntime = min_vruntime(vruntime, se->min.vruntime);
 	}
 
 	/* ensure we never gain time by being placed backwards. */
@@ -819,7 +819,7 @@ static inline u64 cfs_rq_min_slice(struct cfs_rq *cfs_rq)
 		min_slice = curr->slice;
 
 	if (root)
-		min_slice = min(min_slice, root->min_slice);
+		min_slice = min(min_slice, root->min.slice);
 
 	return min_slice;
 }
@@ -835,8 +835,8 @@ static inline void __min_vruntime_update(struct sched_entity *se, struct rb_node
 {
 	if (node) {
 		struct sched_entity *rse = __node_2_se(node);
-		if (vruntime_gt(min_vruntime, se, rse))
-			se->min_vruntime = rse->min_vruntime;
+		if (vruntime_gt(min.vruntime, se, rse))
+			se->min.vruntime = rse->min.vruntime;
 	}
 }
 
@@ -844,8 +844,8 @@ static inline void __min_slice_update(struct sched_entity *se, struct rb_node *n
 {
 	if (node) {
 		struct sched_entity *rse = __node_2_se(node);
-		if (rse->min_slice < se->min_slice)
-			se->min_slice = rse->min_slice;
+		if (rse->min.slice < se->min.slice)
+			se->min.slice = rse->min.slice;
 	}
 }
 
@@ -853,30 +853,30 @@ static __always_inline void init_se_kcs_stats(struct sched_entity *se);
 static inline bool min_kcs_vruntime_update(struct sched_entity *se);
 
 /*
- * se->min_vruntime = min(se->vruntime, {left,right}->min_vruntime)
+ * se->min.vruntime = min(se->vruntime, {left,right}->min_vruntime)
  */
 static inline bool min_vruntime_update(struct sched_entity *se, bool exit)
 {
-	u64 old_min_vruntime = se->min_vruntime;
-	u64 old_min_slice = se->min_slice;
+	u64 old_min_vruntime = se->min.vruntime;
+	u64 old_min_slice = se->min.slice;
 	struct rb_node *node = &se->run_node;
 	bool kcs_stats_unchanged = min_kcs_vruntime_update(se);
 
-	se->min_vruntime = se->vruntime;
+	se->min.vruntime = se->vruntime;
 	__min_vruntime_update(se, node->rb_right);
 	__min_vruntime_update(se, node->rb_left);
 
-	se->min_slice = se->slice;
+	se->min.slice = se->slice;
 	__min_slice_update(se, node->rb_right);
 	__min_slice_update(se, node->rb_left);
 
-	return se->min_vruntime == old_min_vruntime &&
-	       se->min_slice == old_min_slice &&
+	return se->min.vruntime == old_min_vruntime &&
+	       se->min.slice == old_min_slice &&
 	       kcs_stats_unchanged;
 }
 
 RB_DECLARE_CALLBACKS(static, min_vruntime_cb, struct sched_entity,
-		     run_node, min_vruntime, min_vruntime_update);
+		     run_node, min, min_vruntime_update);
 
 /*
  * Enqueue an entity into the rb-tree:
@@ -885,8 +885,8 @@ static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	avg_vruntime_add(cfs_rq, se);
 	init_se_kcs_stats(se);
-	se->min_vruntime = se->vruntime;
-	se->min_slice = se->slice;
+	se->min.vruntime = se->vruntime;
+	se->min.slice = se->slice;
 	rb_add_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
 				__entity_less, &min_vruntime_cb);
 }
@@ -953,7 +953,7 @@ static inline void cancel_protect_slice(struct sched_entity *se)
  * tree keeps the entries sorted on deadline, but also functions as a
  * heap based on the vruntime by keeping:
  *
- *  se->min_vruntime = min(se->vruntime, se->{left,right}->min_vruntime)
+ *  se->min.vruntime = min(se->vruntime, se->{left,right}->min_vruntime)
  *
  * Which allows tree pruning through eligibility.
  */
@@ -7018,7 +7018,7 @@ static __always_inline void init_se_kcs_stats(struct sched_entity *se)
 	 * the upper bound to differentiate the case where no kernel mode preempted
 	 * entities are queued on the subtree.
 	 */
-	se->min_kcs_vruntime = (se_in_kernel(se)) ? se->vruntime : LLONG_MAX;
+	se->min.kcs_vruntime = (se_in_kernel(se)) ? se->vruntime : LLONG_MAX;
 }
 
 /*
@@ -7096,11 +7096,11 @@ static __always_inline
 int pick_subtree_on_throttled(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	/* There are no kernel mode preempted entities in the subtree. */
-	if (se->min_kcs_vruntime == LLONG_MAX)
+	if (se->min.kcs_vruntime == LLONG_MAX)
 		return false;
 
 	return throttled_vruntime_eligible(cfs_rq,
-					   se->min_kcs_vruntime,
+					   se->min.kcs_vruntime,
 					   curr_h_is_throttled(cfs_rq));
 }
 
@@ -7109,21 +7109,21 @@ static inline void __min_kcs_vruntime_update(struct sched_entity *se, struct rb_
 	if (node) {
 		struct sched_entity *rse = __node_2_se(node);
 
-		if (rse->min_kcs_vruntime < se->min_kcs_vruntime)
-			se->min_kcs_vruntime = rse->min_kcs_vruntime;
+		if (rse->min.kcs_vruntime < se->min.kcs_vruntime)
+			se->min.kcs_vruntime = rse->min.kcs_vruntime;
 	}
 }
 
 static inline bool min_kcs_vruntime_update(struct sched_entity *se)
 {
-	u64 old_min_kcs_vruntime = se->min_kcs_vruntime;
+	u64 old_min_kcs_vruntime = se->min.kcs_vruntime;
 	struct rb_node *node = &se->run_node;
 
 	init_se_kcs_stats(se);
 	__min_kcs_vruntime_update(se, node->rb_right);
 	__min_kcs_vruntime_update(se, node->rb_left);
 
-	return se->min_kcs_vruntime == old_min_kcs_vruntime;
+	return se->min.kcs_vruntime == old_min_kcs_vruntime;
 }
 
 static inline void account_kcs_enqueue(struct cfs_rq *gcfs_rq, bool in_kernel)
@@ -7341,7 +7341,7 @@ static __always_inline int pick_se_on_throttled(struct cfs_rq *cfs_rq, struct sc
 static __always_inline
 int pick_subtree_on_throttled(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	return vruntime_eligible(cfs_rq, se->min_vruntime);
+	return vruntime_eligible(cfs_rq, se->min.vruntime);
 }
 
 static inline bool min_kcs_vruntime_update(struct sched_entity *se)
-- 
2.43.0

