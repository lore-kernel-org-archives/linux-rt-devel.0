Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010013.outbound.protection.outlook.com [40.93.198.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7872D3ACA7A
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 04:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125889; cv=fail; b=EH9xjWVWFxtTIvUuf7eUyRBb9SsPjhME3OxH0y0IX9quCC/dATaEdRYfO7F7Bz8XmpXc/AVB/v6/wPL+hl6URimVIDPjhr3UYhm40rIpHdng86vHPyGbqQ8slF/Qqj6v0Lyiz3yenh4f/dWi6PyxdyFsmE+rGbGSy0LWVYHVOkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125889; c=relaxed/simple;
	bh=R0nHqenyeNYVVjDMnviCLdX+UfTVnmEVr1+ra9w3yVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BxR+NQdszw4QLegME0XpDJjPwytxS940ri5K4Wjz8DtFqrbPYI0m7xZZUUHa8oHCA/7VZ3ehl6LMu3XrpCximftGZJ251XdxGkIU/V3EVIAw8RYd7o8E4mLdtc4h0dKWUiZ9uzzmcTaV6DBW826CcPJR0jZ4+wGgBDOSD55RWmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ggP/QFzW; arc=fail smtp.client-ip=40.93.198.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ggP/QFzW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2E3WLTPPNBQvEapcRyoPSh/bie0pTAOTNAAMtP1eSauxq/3EoBIFtDwRXPe4XTX7yd5rotZzOQk4iTb6lTS1JUS/z9+29pMoclBKdn3c6sdCK6ahrI5uw/NSTK1IC4Wm+thRS/OO5Fp2Uo3o0AIN3NsZSUus4IWbftFkl4QyAFhlmYbVpoXS5qn2GS2Gs67KhMOo5Q39BzSJrSzYaFWXs0ZZCRamhnNXjHXJ9c0bPeM0+8f+avW10rqJXX2GyTn+2WoWoBAclkJ6Qz2NQp0JIobP+EL4CpNIPtWdkYqnDYW/buO12IoPlr+/CxStTzNL13RNvoy+RiKddsValOy9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoRbqOb+jGLYfih3UkWj/4f9aXKcVTyYumGMqAanD/g=;
 b=MkEJOlhV0JB/2e9foCZbty2K8dBcZoymFmPr02MopMru4dZVWG6xEnVaR5U4QNnauiDApplCfpCaLa+C1rX9eN/ia9gXV1vu5NKPHCy5kX3OeTkiPMn6GQ4b0dkjmGVeEQOO0W/2Mepw1xvILAXdvSzAV/u53ViVLVU6IKoeLD0R5oVDvYYe2ZUuJQjQumWPNQRLivNv1lob5NugJh5tW2KygMq3T8v6cIvkNENUarw2swFeqW6BTXwwBs2sM4c7kFH/cn92uGM5MyTrSARyVQBb4Tk9ZtSEgnE6+dDltCZnPAjU3ToIcDV+7yK6mSywLk9vyGIT6F30TO5ai9Ho+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoRbqOb+jGLYfih3UkWj/4f9aXKcVTyYumGMqAanD/g=;
 b=ggP/QFzWFoMir8IWT1KfYr/TBUTpaj230yi6vVlI48LD2nTaXDFs8CltFC5DYY8ivDbq59X4Ck4d1AiCE7kRPUwVxDy8KW4546ul0RDANcaNbZZnFhfCBYSrZq94maKQ8MWLNzSOtM3DUDrE+jYsMMhIEs5wjNu90vdbULeZr4k=
Received: from BN0PR07CA0026.namprd07.prod.outlook.com (2603:10b6:408:141::26)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 04:44:39 +0000
Received: from BN2PEPF0000A98F.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::3b) by BN0PR07CA0026.outlook.office365.com
 (2603:10b6:408:141::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 16
 Oct 2026 04:44:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A98F.mail.protection.outlook.com (10.167.248.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 04:44:39 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 23:44:32 -0500
Received: from [10.136.45.168] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 15 Oct 2026 23:44:28 -0500
Message-ID: <a92f4a71-614f-44e4-b4f1-38e92deffae2@amd.com>
Date: Fri, 16 Oct 2026 10:14:27 +0530
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Mapping from preempted task to running task on same CPU
To: <paulmck@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Joel Fernandes
	<joelagnelf@nvidia.com>, Clark Williams <clrkwllms@kernel.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>, <kernel-team@meta.com>
References: <e8b6b372-d16b-4939-aa7a-755b7149e0fb@paulmck-laptop>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <e8b6b372-d16b-4939-aa7a-755b7149e0fb@paulmck-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A98F:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: ad33dcaf-d79f-4b7f-0e5f-08df2b402ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	RHmRJcvAIb1BhAtEu3UN9JM9wRHG9lsW/CvwkGdyeNLhKb7yTknuUFoOcU3Bi3GH5pqGX/DXoiL7OsT2o4qxVB8I62uoZUgpSSk2ff07xwROQ1MhBxaL2Q+GC47b3buqCQrvBF1/cji3r2BUzugSRn01SUcu+w6B6Qciq9BPSxlTvlnq/2sCZM94dVQTdIcNczZ48/i7FhKmH4bIoDigUKMBYibCNH0b7FggAkIaSA6SFNi0duqrUK+iWmKLHq3SdK9gT9Ly+cYPxFJYRkJtPtj4gT5JbV3+j/NFOD6mvEo//vDIdN+tww8KCyK8NOIZXC5/4HVZEnxpC+FWRYjYz3+iMbTlGvrXPIXhKCMRajgRyyApk+mesX8jjWaGt9RFVoro+1UWLtad/RMTVNWVEL68ykllIPJuOfr5NAinUi3E57rhTp4BFvni67eaGsyr68zUHhiySWpSl22bCpgzNCaPmk4kb5X6K7HNFVseAdyP/z9vtnCHPqjDofQWGe6nc1Kfss4ARLvTUoaIKipBxDurxPUexZ/oCIio1wlhbRHrjYlzFPbf1SgQunvx4UbAmxcqNn305i0UtLc2KIs5tFGqyJCNE4IS7M2HiUyz/9Gj9LhcUYQ+IN/O6H3Ogra8gWWrQAzmdlJQF60fQ9CWGrdV4n1f1GeMuQ9i1rXRj2WYY4hPANorUsi/iSQ3bkJ5+X38zLf0NwSwk4SoYdNkJA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ViDjvkxpOic3QTHdPQUqIe9neZsuj7Dal/vxidlzv3YpndHHi5H512sntTWe2XxmRFEYZnY79uE7M+BBahYA6uybbCv+jguQIEGpvpi7rSVxTKC2CKCqZVchYaSWv6ZlQP1Cy4QyI7+xxR/PwWXo1WPpeiBoIjB1y9xRGWwVpHh3IriCZPIifKhgUAUn6nAprV+MlW6hNCMRes5h7eQOfGTmXbDknxhsygrOyD/gYNN128bj4GNCWOu9WWoewhXNb6FuKH8yu5BiVWkO2IxEFWYhOCq6fukBh5xgCqGT+TdEHrd42AI4kwipnrF5w+llv1cRm8+FpAddRKb2tZGKuIVKH63BnRG9JBtX7jZVO/oyqJKWcjnt57WEbSsHO+LHCUKf0NQv5xWljHmCN/cnrNbwHV5oYej9Kz3SVY8bdlHXcs0vmClHTtZGJh1SLhPJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 04:44:39.1888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad33dcaf-d79f-4b7f-0e5f-08df2b402ff4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A98F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197

Hello Paul,

On 10/15/2026 11:11 PM, Paul E. McKenney wrote:
> Hello!
> 
> One of the commits [1] that I used to chase down a recent bug [2] (and
> thank you again for the fix!) uses the scheduler-internal cpu_curr()
> macro to map from a given CPU to the task currently running on that CPU.
> In the commit, the actual operation is mapping from a stalled (AKA
> preempted but runnable) task to the task running on the corresponding CPU.
> This tasks's ->comm and ->pid are then printed in the RCU CPU stall
> warning console output.
> 
> One of the real-time folks voted in favor being able to use this (the
> group is CCed here), which suggests that I push this commit to mainline.
> Which means that I need to do something other than my crude hack of
> creating a rcu_cpu_curr() function in kernel/sched/core.c to get access
> to the scheduler-private cpu_curr() macro.
> 
> Please tell me what I should instead be doing (in the check_slow_task()
> function shown below) to get at this information.

[..snip..]

> @@ -327,6 +332,9 @@ static int check_slow_task(struct task_struct *t, void *arg)
>  	rscrp->on_blkd_list = !list_empty(&t->rcu_node_entry);
>  	rscrp->rcu_rdr_running = task_curr(t);
>  	rscrp->rcu_rdr_boosted = 0;
> +	rscrp->rcu_rdr_cpu = cpu = task_cpu(t);
> +	rscrp->rcu_rdr_cpu_offline = cpu_is_offline(cpu);
> +	rscrp->rcu_rdr_cpu_task = th = rcu_cpu_curr(cpu);

If you don't mind taking the overhead of rq_lock, you can use
cpu_curr_snapshot(). It should give you gives a rcu protected
task struct of cpu_curr() and ...

>  	if (rscrp->on_blkd_list) {
>  		rnp = READ_ONCE(t->rcu_blocked_node);
>  		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
> @@ -352,6 +360,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
>  	int ndetected = 0;
>  	struct rcu_stall_chk_rdr rscr;
>  	struct task_struct *t;
> +	struct task_struct *tc;
>  	struct task_struct *ts[8];
>  
>  	lockdep_assert_irqs_disabled();
> @@ -372,17 +381,24 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  	while (i) {
>  		t = ts[--i];
> -		if (task_call_func(t, check_slow_task, &rscr))
> +		if (task_call_func(t, check_slow_task, &rscr)) {
>  			pr_cont(" P%d", t->pid);
> -		else
> -			pr_cont(" P%d/%d:%c%c%c%c%c%c",
> +		} else {
> +			tc = rscr.rcu_rdr_cpu_task;
> +			pr_cont(" P%d/%d:%c%c%c%c%c%c CPU %d%s %s (%d)%s",
>  				t->pid, rscr.nesting,
>  				".b"[rscr.rs.b.blocked],
>  				".q"[rscr.rs.b.need_qs],
>  				".e"[rscr.rs.b.exp_hint],
>  				".l"[rscr.on_blkd_list],
>  				".R"[rscr.rcu_rdr_running],
> -				".B?"[rscr.rcu_rdr_boosted]);
> +				".B?"[rscr.rcu_rdr_boosted],
> +				rscr.rcu_rdr_cpu,
> +				rscr.rcu_rdr_cpu_offline ? "!" : "",
> +				tc ? tc->comm : "???",
> +				tc ? tc->pid : -1,
> +				tc ? (is_idle_task(tc) ? " (idle!)" : "") : " (no task)");
> +		}
>  		lockdep_assert_irqs_disabled();

... since you are IRQs disabled, it should be fine to use it here.

If you don't want to take the overhead of rq_lock() + barrier,
you can perhaps define a cpu_curr_snapshot_rcu() like:

    struct task_struct *cpu_curr_snapshot_rcu(int cpu)
    {
        return rcu_dereference_all(cpu_curr(cpu));
    }

in kernel/sched/core.c and expose it similar to
cpu_curr_snapshot().

I'll let Peter comment if he hates it or not ;-)

-- 
Thanks and Regards,
Prateek

