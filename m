Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0313F1EE032
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 09:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044240; cv=fail; b=ogUs/VCbAby9P2iDaoSHelRB6Lh1ZXm2nN/ir0Bzas4o0oaO9u+4ae8cyaCeYjLrepgov0qsH2yanhUwDMWSRo3UuHtX9jlLqko1T7p/7yem7QbzHgMQQ3T3yb27iROpi8CLqy/Q3n9imBirWaV4kh26pf1JG4KecWTAyg++r8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044240; c=relaxed/simple;
	bh=sbZhAAHiTVfsHVPifa6mzEHQs+ZPUQL/KLrZ3xD3+co=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avu7jU3/PicMo5Z9YPp6HzHo8Sh0rG3GAF5Y/RsQHN/pWBB7IYvjBqSfGeK/KtD7TAqxrn06e/eYOU+U4k30a4wc+Bc/7AHTjyCQplXTfmcTM9aDRqwV5E1Q2eH+Sjzgu9kK8t6BP8sx82Err3NNfFkqLkIwDaIoe5e2mNBxH1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LEMS2rUv; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LEMS2rUv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8v8uqmEw4QCiiEnCv4GCtbJ2+1rHq803jqubVG/lWf9w+bBDC4EDvlgnlXSgKZo9rqzEB4jlywQNptnMGgdPqn402aSs3s5xsf2g2yCFGTvTK25YAv/MzGf+VNeMVFwmoV7ABu4dE8YAYIf+3owKziGYqT3zAgn4DGMXqM9L+F+qdnF9iHg8r9hrs7SD3OwhOeZgdfQeLF5fW9Dlcu83dMVDO2wYvD5qK5ZxUWqrmJe/dawN+x6svzL9emTZlp2iWqy2/rD9TqAZxoXsA/MKfpnr18f+Rd4TMVLGsPY+RqWiLOdRi3LSAT5e2rnvY8U1WgsiGu3yaMTY9VVjZ+4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8vqVAnvAG5sapvjR2GbHSLHilK7UfH5obQ+j0sIp3E=;
 b=adDa8A4mH8JQxcWhV7kvOTwY77u0UtSeU9tFWtzivi6oAIJRDXr68XEfnGQivhku2QJOZW6RRrpfj/+uVx0QWgrK5qAmsW1t2FoDXPFizNm00wQxePx98bqdlNEyV3+A1kmYoqWaf6YiJf2zRMCTRt7+MJOcdo8ALIzCFc69lvZu8P2vhvWwT9HMvLSZBZY7MQRmKcog5XT/pZCYZ9kpC1lqPVGwKrXmQ5+FwedDQsXL/KXt3pGUAoWBJY4hW38moVM/noaZuZuEVhiWl/MhpflxwZK2vHcq10P8Y5A5rT4aY+L2/BPnO7QG9hpui5nfFMeJC90qG2M6Kg5TTSKHWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8vqVAnvAG5sapvjR2GbHSLHilK7UfH5obQ+j0sIp3E=;
 b=LEMS2rUvOuesAxM0AY7D8lNMeUqWg4+bUEijErfFA1UNEbfFgEYbWXlkNFl3tGQa1654CzNNwDbOB5E6UBq42ct1GCo4aXR9+9rSuxC7gBCgfWIQcgBxodmS78fEaHzTMaUBYQ3oGwEBAxq9JmrGbEwDPsOko3uDMgvGytsY3+s=
Received: from DM6PR02CA0168.namprd02.prod.outlook.com (2603:10b6:5:332::35)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 09:37:15 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::61) by DM6PR02CA0168.outlook.office365.com
 (2603:10b6:5:332::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 09:37:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 09:37:15 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 03:37:07 -0600
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
Subject: [RFC PATCH 11/22] sched/fair: Prepare unthrottle_cfs_rq() to demote throttle status
Date: Thu, 20 Feb 2025 09:32:46 +0000
Message-ID: <20250220093257.9380-12-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|CH2PR12MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: 64b547db-5823-43bf-e8b2-08dd51922930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SbbeaAIwYMdDQhH+siHPIoMt0jCw/eGMgWjoABaL9h6rZt6C4OJUlS5iLh+c?=
 =?us-ascii?Q?5pxFs5TxhIahp277oXS0t3JHnlS38sPa3yQNMXv3tKH4HRk8hJFTydJl/Va0?=
 =?us-ascii?Q?LMG2f7ua5ZArDw58LLQvRJi9t+RHjPKi7ncxJxF8LTt7zJ0T+/Tq0FDqM+NR?=
 =?us-ascii?Q?YBzv/oGaoPt/QdLC/Cj81fIAwRYhPtn/oZgN1rd+nUcgLIl+J9UBSz9zKFCi?=
 =?us-ascii?Q?s694ehrHHfLeedSwzzyXE61AT9/icl1k06HoFb09PH41mwgBAJdQSU27eP0c?=
 =?us-ascii?Q?m5Cl7DdlPgeNP1MJsLPmeP2FflfBvvkhkduDBbaB+5VC9G2f5VmsUEvYC3y6?=
 =?us-ascii?Q?RIl13EnRNdbu76iXPquelK2bkmOxGVF+vnQbaG7b0HfgzsLgv4V79kKOqsFY?=
 =?us-ascii?Q?Xlm3mDkDBTbmWC3DWIcYOyfueJf4QRQuR2YrbDKTQd/ztDRYIosCRQOtwz2x?=
 =?us-ascii?Q?j5rUmrX57o7zhfadLIASJfMjOc2ZVPHQU/F+3GU3vUpKcxrXFpjji8VNPgfr?=
 =?us-ascii?Q?1GoKrDDQo+zTmsiamBaDhumoWqiHw6VryIl3m6wb6/eNkXNVH6Z+wq51gayK?=
 =?us-ascii?Q?kwmjxgL3Qbsmpxtxrs8V3kqVPVgJtJyJ6kNsGBSMZtPyRfe0Nn9CslQAk7UX?=
 =?us-ascii?Q?FUVey6z5YhknNf4vHwGP1zr27SUnVKqe6RM9BpgEOnUhVh1NyyPGPfGfYphf?=
 =?us-ascii?Q?RsxknF+WZtB9hRuY33pOMQ/qu0WeNKyUAQ0qRlVS2zWQJKMuDp9WQhxyzteT?=
 =?us-ascii?Q?qvglb6TDawhGO4fOIsPlfgR99qm4yfBqNf53Te5Ngc2cY78RRWgIYORqn152?=
 =?us-ascii?Q?+shRbU7wWrqv09lEPZfaAuC68SAiirI6kkLbrUqxWXpkELMEukPobhv0sJDD?=
 =?us-ascii?Q?uKsNDIpalU1uPgPZaM8L+LNViTMQgQt8we6o+wywjOOYuMvFXppoOI3ZrN8u?=
 =?us-ascii?Q?zudEmpaPRW0tJyVbysdHz7mlZksC7KcCSZ75xZy6heb0TTw+sWLyVRHuUpb8?=
 =?us-ascii?Q?OuS9KUwDZKibMTnPNkMrxu8HZZerZEgvol6Pt0QsN2w65/IVjZyaBfavQEhP?=
 =?us-ascii?Q?WoJLvlT/NkBCLpyQbdlFY+GH6684og1X1VPWyCtcJMXOK0IbPUT1OuI2qU8O?=
 =?us-ascii?Q?aLY9H9CJT69Jff0fftnDJ4HO8ZPU7PJyp3mSYYQpkEmSSC28l/871eMxZl02?=
 =?us-ascii?Q?+TeenBWplDmuHxoUEaZklw2vjghEP65ForSlDHoCtFdwtdThIsjAzy0+ZKBD?=
 =?us-ascii?Q?E/Djs0OdLBhBtxrUiVDrfey9KxFpz+PSb3a6mXdBeLIH83wEk6ZHvr5Bg3Hz?=
 =?us-ascii?Q?p1+d/VcnVVkeg3mmAkl9+cIuDbbaIVz7WBtT5S9TCSk/dMesqZP3441yMfaL?=
 =?us-ascii?Q?/CpTVdZmEdKEOqpfAT1eFcofil9VxZ+WORP1Ebo9Fj2LQo3zgObCYmSIxm6A?=
 =?us-ascii?Q?BdaHJNXih7yKwkQtGV0KqBQ37N24C4bqKL36kJAaTAkwxP1sCd4cPP738gAh?=
 =?us-ascii?Q?7MBDUB4AKNxOQY8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:37:15.3687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b547db-5823-43bf-e8b2-08dd51922930
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261

If an entity which was blocked when running in kernel mode wakes up, a
fully throttled hierarchy needs to be demoted to a partially throttled
one.

Prepare unthrottle_cfs_rq() to demote the status where the caller
explicitly specifies via "demote_to_partial" indicator that it is
requesting the throttle status to be demoted.

Modify all current callers of unthrottle_cfs_rq()() setting
"demote_to_partial" as false since all the existing scenarios
completely unthrottles a cfs_rq.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/core.c  |  2 +-
 kernel/sched/fair.c  | 39 +++++++++++++++++++++++++++++----------
 kernel/sched/sched.h |  2 +-
 3 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0851cdad9242..a797517d3dcf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9488,7 +9488,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 		cfs_rq->runtime_remaining = 0;
 
 		if (cfs_rq->throttled)
-			unthrottle_cfs_rq(cfs_rq);
+			unthrottle_cfs_rq(cfs_rq, false);
 	}
 
 	if (runtime_was_enabled && !runtime_enabled)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8e1df614e82f..091493bc8506 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6082,17 +6082,26 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	return false;
 }
 
-void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
+void unthrottle_cfs_rq(struct cfs_rq *cfs_rq, bool demote_to_partial)
 {
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
 	long queued_delta, runnable_delta, idle_delta;
 	long rq_h_nr_queued = rq->cfs.h_nr_queued;
+	int throttled_state = cfs_rq->throttled;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
 
-	cfs_rq->throttled = CFS_UNTHROTTLED;
+	if (demote_to_partial) {
+		/*
+		 * A demotion to partially throttled state can only be
+		 * requested on a fully throttled hierarchy.
+		 */
+		SCHED_WARN_ON(!cfs_rq_h_throttled(cfs_rq));
+		cfs_rq->throttled = CFS_THROTTLED_PARTIAL;
+	} else
+		cfs_rq->throttled = CFS_UNTHROTTLED;
 
 	update_rq_clock(rq);
 
@@ -6101,9 +6110,16 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		cfs_b->throttled_time += rq_clock(rq) - cfs_rq->throttled_clock;
 		cfs_rq->throttled_clock = 0;
 	}
-	list_del_rcu(&cfs_rq->throttled_list);
+
+	/* Partial throttle should retain itself in the throttled_list */
+	if (!demote_to_partial)
+		list_del_rcu(&cfs_rq->throttled_list);
 	raw_spin_unlock(&cfs_b->lock);
 
+	/* If cfs_rq was partially throttled, we have nothing to do */
+	if (throttled_state == CFS_THROTTLED_PARTIAL)
+		goto unthrottle_throttle;
+
 	/* update hierarchical throttle state */
 	walk_tg_tree_from(cfs_rq->tg, tg_nop, tg_unthrottle_up, (void *)rq);
 
@@ -6176,8 +6192,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 unthrottle_throttle:
 	assert_list_leaf_cfs_rq(rq);
 
-	/* Determine whether we need to wake up potentially idle CPU: */
-	if (rq->curr == rq->idle && rq->cfs.nr_queued)
+	/*
+	 * Determine whether we need to wake up potentially idle CPU or
+	 * reevalutate our pick on the throttled hierarchy.
+	 */
+	if (cfs_rq->curr || (rq->curr == rq->idle && rq->cfs.nr_queued))
 		resched_curr(rq);
 }
 
@@ -6212,7 +6231,7 @@ static void __cfsb_csd_unthrottle(void *arg)
 		list_del_init(&cursor->throttled_csd_list);
 
 		if (cfs_rq_throttled(cursor))
-			unthrottle_cfs_rq(cursor);
+			unthrottle_cfs_rq(cursor, false);
 	}
 
 	rcu_read_unlock();
@@ -6227,7 +6246,7 @@ static inline void __unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
 	bool first;
 
 	if (rq == this_rq()) {
-		unthrottle_cfs_rq(cfs_rq);
+		unthrottle_cfs_rq(cfs_rq, false);
 		return;
 	}
 
@@ -6243,7 +6262,7 @@ static inline void __unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
 #else
 static inline void __unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
 {
-	unthrottle_cfs_rq(cfs_rq);
+	unthrottle_cfs_rq(cfs_rq, false);
 }
 #endif
 
@@ -6329,7 +6348,7 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 		list_del_init(&cfs_rq->throttled_csd_list);
 
 		if (cfs_rq_throttled(cfs_rq))
-			unthrottle_cfs_rq(cfs_rq);
+			unthrottle_cfs_rq(cfs_rq, false);
 
 		rq_unlock_irqrestore(rq, &rf);
 	}
@@ -6786,7 +6805,7 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 		 * there's some valid quota amount
 		 */
 		cfs_rq->runtime_remaining = 1;
-		unthrottle_cfs_rq(cfs_rq);
+		unthrottle_cfs_rq(cfs_rq, false);
 	}
 	rcu_read_unlock();
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 22567d236f82..bd43271fa166 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -554,7 +554,7 @@ extern void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth
 
 extern void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b);
 extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
-extern void unthrottle_cfs_rq(struct cfs_rq *cfs_rq);
+extern void unthrottle_cfs_rq(struct cfs_rq *cfs_rq, bool demote_to_partial);
 extern bool cfs_task_bw_constrained(struct task_struct *p);
 
 extern void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
-- 
2.43.0

