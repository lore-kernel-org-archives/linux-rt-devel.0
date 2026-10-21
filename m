Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792554074;
	b=Z23as05q3J2qxxwVBCJdv1MJPJZ+8nbVQLl6gPnRaYwWTm3F83niQzAnpFM1ff7vHEFl
	 zxF/CTRPXaAFgXeafjgQs+uiADMKYZf4FrBUVi6Zy6cO2KPYNRhcSHz9jdFgUsblnpBt7
	 KieEgfQ4SLPHP4L0KLGECvs76lhuUm9OyTjWSvu9WtTokS8w8eZ/CJeYe8mYrLCrMtBsy
	 tfSO1i6QbgdbnND+mPfGnt67lh1xJ/wv65/3tNPPTrExNf4x1qcsqYV40S/aD/TpXCDr+
	 JuI6XTpZw1x21HffJRye/6pORo9lhiTHH69Kwu4pqGZu01aCaktkyYXyhjrlFn74dqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792554074;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 CC:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=iJt9Lku9ZTIA7h8E2r15ZUbMqbDELnTBdSjAXJZJubc=;
	b=SD7ruTrtuWzfB36lCRAQekgsvX+mRlAAiS20l7yWWhx7/WVhpapCg08qHZ6Spn0Ju26H
	 1YFRXBqrmpJ1VSU1lpuqhLxzp3OsjBfI9LjgsDix122HHjGL2sf9CU8rVoU6lzloou+Nf
	 xpQ7bogq/W98Pqw/d2HOZSaltE6m+ZoGu8fgPL77GC8uKM9AWBKk6faI4gBl9al8/Synn
	 orAADG8r7l67nsN+rSEdg51+kF0fb0miekh3zFgFnh5N8Z9QjhereGEZhkum0IiXIWAKo
	 bGvUoNIb9nas1Uhrq3EBiFwvNAvlt4UacCmxDoPMaSzz4WIV/ZKC/pgQdwxwR+ynIuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="vzJkZuF/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.65
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F665606A31E
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 03:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F665606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vzJkZuF/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csA63bkuMf20BtIL2Udvj51Ouq8QLnwRFuYzqRG1wCfQ8imIH8ugokfyiOnMWA/ZX2dQL4TsZNKjpFt8nI7PXyX3OpjBIFGuKXL9ohWUKkyj9u3KoO0J9mkDZd7xvIgm0jP1JHBG4dvQsSR3h8Up5f/Oh++dEQUdH56WPzfm+U+wWsIlv96KXTG3ONWfi2wZKueb6anAyC9kfBg5gxuuEyV+dOVn1yvV0gW8ZGp4E2DT9lqc+tRhCvnTS9a0UwV2hL56quP1MZ+SgwFqGCC0OlUrAJHklYJjZe6LF68l3duDnENlRJgsR37tVbcaLOB3TC89nev9EJ7o5twgjbWb9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJt9Lku9ZTIA7h8E2r15ZUbMqbDELnTBdSjAXJZJubc=;
 b=d+zEkI8l0BPrBPRMmAYzhFgQiH5L2ME3qylFRK4elMPuEjuYui1eB+ZTheIm+wrx35/nxy6NpfInSoHXYioEHpSAtel+xuYvxtx1Qd14kXcksD1G1fEOAfftX702vcWGFwFRd4VeletbAJT68JqPuGqCctODXtPz1bWA5N8PSdYObt9hapvaBOERbuELkBJHJilPpMnfcNg6ThXjSObkqSLDBDWj/7gSBOlHpHuMGRdQNYf08YOnNnpvemqgfDg2Z3OT8++VpVpWJ6kugj/aOIlG2UxXCcZL+sZqWdtmJoEHi97kcw1VkVfeUH6RFcS2N4BU7m9lWXj/L9Mjod0/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJt9Lku9ZTIA7h8E2r15ZUbMqbDELnTBdSjAXJZJubc=;
 b=vzJkZuF/Jlz+CiV3nVB3qBXBdwup7Adg0HtN2kX+ZnSYXwehVeEs7doZYuA+ZsIFMMIcPmwXDo6UgSBm9CkKKdJAvbUVVy1eNGZdDuqxSbyQGeLldmhsP0ybaM2EmPp9k2Tb1z1pBCiINu9LiGGzACbwf9+S5v1qfNFmaigT6MQ=
Received: from SJ0PR03CA0108.namprd03.prod.outlook.com (2603:10b6:a03:333::23)
 by DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 03:41:09 +0000
Received: from BY1PEPF000264B2.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::8b) by SJ0PR03CA0108.outlook.office365.com
 (2603:10b6:a03:333::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 03:41:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B2.mail.protection.outlook.com (10.167.242.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 03:41:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 22:41:07 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 22:41:07 -0500
Received: from [10.136.41.43] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 22:41:03 -0500
Message-ID: <0d0974b0-5235-4764-abad-0a665c27a1d0@amd.com>
Date: Wed, 21 Oct 2026 09:11:02 +0530
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Print CPU that preempted stalled reader wants to run
 on
To: <paulmck@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Joel Fernandes
	<joelagnelf@nvidia.com>, Clark Williams <clrkwllms@kernel.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>, <kernel-team@meta.com>
References: <e8b6b372-d16b-4939-aa7a-755b7149e0fb@paulmck-laptop>
 <7a827d0a-1a69-4be6-8b69-9a9769b182b7@paulmck-laptop>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <7a827d0a-1a69-4be6-8b69-9a9769b182b7@paulmck-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B2:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: b7dc2b07-abc5-479e-67d8-08df2f2524dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|36860700016|82310400026|13003099007|56012099006|4143699003|11063799006|5023799004|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	wC9r7Uy4uWsYSvtN3JXCLIcNJtdq1ll0kLYSKF6Tvp0qyxsi2ElH3YsQ6DKzWJLyJ//NvuGEv9AFpcPsRQmtEoITwmfQ3DtyETkDbN9B8yPacFyw8aALS/a2J4mHxQUQ3p/MenSBtbAkbUSqEGK8Aet1EpQJ3cVD/A9vI+GRbUu9AoDBlBRSXCkX6znG+CjbLTk/uD5JYN9xkASeK5VRX1/MiIxZhx44MpDE1bAR4J6zR+aPQC1dSeXa/ZTciu4O+yrkAv9hGZfew8ddC+0yQIwycSg0FvRrP0ZancktgpcDjSrZuPweVx6U888Lxb6UzaISuosm8mPXBRFzTNYUJIhGVri8nloRe9P+qoJBoCDrPPKbx8UQUk7m7nsKakMpGJZfq/jYNyClApI33x4Wjq6qR8cQoTQ6gXmc6SmfHLhrjaIMgci4BCvGOzZQjJgKFIGwmnrykJXk8i+av/aPRItIqzIpzfK8o9AvKIOsABNpw2Mkk2wVMDN26WiSyi9qWU2OINMeat9k8sEYGEtKvt1j8E2AFmCCaoDBh0eN7/NxLWpONx0KkcGWRfA/OawgudBswWJrJBTYleK4kzOREsluk3SuWQuzEtbFqjwNDIDO7SKSRWGhI+5pDE6zWoBudGWZV3Gine9BR3eMnJosjdkyRa3pXn4OU8FzkbH8eY4oG/LXci+rqR7VNKSQEzfyND7HV6R8w0qicsGlnoOAsQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(13003099007)(56012099006)(4143699003)(11063799006)(5023799004)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Zn24194avExxDwAet2YpnuBxwNnKbERXIEADvd3njFpPT75CIMMaokp3+8lVmg0LfRFUCu3COG9P6Wetqc35XkqrtATh3yi5GEXCRYyLSNcaCram3fHUML9xs/YjRIhciPjmVxt3gmt0Zl4abGcvF/1i2Lr0/utAB/7X3pYVwP03h7Qfy7n+hI+PtSXU0GNyzsQN6XyllTbW9C66ED9UTSXmKCouct4R3qUaZZa/ML7VkkKWlOpdu5ppy3eU+es0Gv7sh8vkhLQuv6aeyFJSpQQG6+MD/8rIPTKdg4rv7MPYIg/DjkL6oSYdAbY04y85qSqK+LPj8e3LetyLjIsaRnyR29e8aR1ZCra/X8aXy8+GLXZvMEmaz0zCaZJBW3tE3eT9oxlrBf2Qv/7Y40RqrnVktwuEcsCevCVhXYqO1j+oa5ULtZb/J35xEKBo2sTV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 03:41:08.7363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7dc2b07-abc5-479e-67d8-08df2f2524dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527

Hello Paul,

On 10/20/2026 2:17 AM, Paul E. McKenney wrote:
> This commit defines a cpu_curr_snapshot_rcu() function that invokes
> rcu_dereference_all(cpu_curr()) to determine which task is currently
> running on the specified CPU.  The RCU CPU stall warning then uses this
> new function in order to print the task that has preempted the stalled
> task (the stalled task being the one that is in an RCU read-side critical
> section, thus preventing the current RCU grace period from completing).
> This modified stall-warning message also includes the CPU, along with
> an exclamation mark ("!") after the CPU number if that CPU is currently
> offline.
> 
> This is a potential step towards allowing people (or LLMs, for that
> matter) locate any tasks that might be preventing the preempted RCU
> reader task from running.
> 
> Adding a get_task_struct() for the currently running task would be a
> bug because we are not in a position to prevent that task from exiting.
> Yes, yes, because interrupts are disabled throughout, the corresponding
> task_struct structure cannot be freed, but following sequence of events
> is all too possible:
> 
> o	The check_slow_task() function places a pointer to the task_struct
> 	structure in its local variable "th".
> 
> o	The corresponding task exits, reducing its task_struct structure's
> 	->usage to zero.  The task_struct structure is therefore passed
> 	to call_rcu().
> 
> o	The check_slow_task() function invokes get_task_struct(th),
> 	setting th->usage to one.
> 
> o	The rcu_print_task_stall() function invokes put_task_struct(),
> 	again reducing ->usage to zero, and again passing the task
> 	struct to call_rcu().  This results in either double-call_rcu()
> 	or use-after-free, depending on when the RCU grace period for
> 	the first call_rcu() completes.  Both outcomes are bad.
> 
> This commit therefore relies solely on disabled interrupts acting as
> an implicit RCU read-side critical section that prevents all of the
> task_struct structures from being freed, thus avoiding the need for
> get_task_struct().
> 
> The original get_task_struct() calls in rcu_print_task_stall() on the
> tasks on the ->blkd_tasks list are safe because those tasks cannot exit
> without first acquiring the rcu_node ->lock that this code already holds
> (because these tasks must remove themselves from the ->blkd_tasks list).
> But it is better to be consistent and rely on RCU in both cases.
> These pre-existing get_task_struct() and put_task_struct() calls are
> therefore removed.
> 
> [ paulmck: Apply feedback from K Prateek Nayak and Peter Zijlstra. ]
> [ paulmck: Apply feedback from Steven Rostedt. ]
> 
> Link: https://lore.kernel.org/all/a7a21bf3-a7d5-45bb-be4f-0119fe53fa20@paulmck-laptop/
> Link: https://lore.kernel.org/all/e8b6b372-d16b-4939-aa7a-755b7149e0fb@paulmck-laptop/
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

I tested this on your old dev branch on top of commit 5433117c67f0 ("EXP
rcutorture: Disable RCU priority boost testing on non-TREE03 scenarios")
and the idle state during stalls are reported correctly.

Feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 8b3d47a325cca..3606e5a2cec32 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2532,3 +2532,5 @@ extern void migrate_enable(void);
>  DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
>  
>  #endif
> +
> +struct task_struct *cpu_curr_snapshot_rcu(int cpu);

nit.

I think this and the function definition in core.c can go right after
cpu_curr_snapshot() in respective files to keep the related bits
together.

-- 
Thanks and Regards,
Prateek

