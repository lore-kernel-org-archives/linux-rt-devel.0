Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886EA31CA50
	for <linux-rt-devel@lists.linux.dev>; Fri,  9 Jan 2026 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767957827; cv=none; b=G2+fH37ttChyncLe59VMEbA4KksMOJ0iobjbnmvq+QcnnYdYxhFcmUQHuCgmtzSBhRTLx/0yucU/fF1QJ5AfZAYU/DwCtUz2OfZfSuhqM72ujdmb1KOQcIo5s0DdTCeXPZvyKuRAR/r5IfIRrEloB7is5HRuD0z1iUtaUJPq4VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767957827; c=relaxed/simple;
	bh=sXYPbVWOPeHQbG08JRmsQ5d2gTU7uqXNpY6bcgJMx90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rGK6dLK8V1U/BRlzqABTBW0GB07/CeFx9OJGs/BIVTrScTpaJhDU59pRDp5Q7xDVJMdRghECQy8ag9BIf69M4ElrqUIkJ5vM3dzADRbofMKI/1tl/4CFI/CLaSVhhhFAoEECvrLrDUXjotfA0bA5Xp0s/PV+F6IYQsa2obrlNyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BbG9BTLo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BbG9BTLo"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 608LHPDu029308;
	Fri, 9 Jan 2026 11:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FeIuBh
	hbcNpZ0Ykr+FEQZL/FlSRu1Y6p3taKQA0v7fI=; b=BbG9BTLoFegpsmoXlMuG9l
	suB2iYyAL8Oxdq0JYyj3RJ7jcX0IHk7yAO3pvpsZOB5nV4bXcRyBNY1rFA277nAG
	H8efkqooMy6b6m+vh9ErdH42/+/5sBt75XkAnr26pokN4ry4ltxL7huT2U8zcIN2
	5/9ob9rLu3jmKI/T6qID/0n7uiLee4vpg98NwT7kAACUfgUUpLXf22FOvfLzPpNu
	ftCurADtGeEBGU3oKofWNwD7Whst0QcvJT9U0gEe4GnloksEMIJKy+1mpKvPl4o5
	1+2OmCvddxcvKqrZ8mwwEwZ4ti4jLU1B56vNP1bHKyorf4b5Y7aq+76N6WEC+FnQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4berhkhp0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 11:23:12 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 609BHAVe003488;
	Fri, 9 Jan 2026 11:23:11 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4berhkhp0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 11:23:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 609AhKB8012568;
	Fri, 9 Jan 2026 11:23:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bffnjvaju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 11:23:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 609BN8fK53084428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Jan 2026 11:23:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BA252004E;
	Fri,  9 Jan 2026 11:23:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68F9C20040;
	Fri,  9 Jan 2026 11:23:05 +0000 (GMT)
Received: from [9.39.17.37] (unknown [9.39.17.37])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Jan 2026 11:23:05 +0000 (GMT)
Message-ID: <a86b6bbd-c0ed-40dc-899f-ba162332c80a@linux.ibm.com>
Date: Fri, 9 Jan 2026 16:53:04 +0530
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Further restrict the preemption modes
To: Peter Zijlstra <peterz@infradead.org>
Cc: juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, clrkwllms@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>, mingo@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=P4s3RyAu c=1 sm=1 tr=0 ts=6960e520 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JfrnYn6hAAAA:8 a=IHo9bmG76QJ_CpW-HQAA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: Sfmjoe6b_QINIz1_bew5dkarZ-nazBUu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA3OSBTYWx0ZWRfX2C1mHvUF7+yk
 8HM0pJCBOOuVJYlfDhemThWwevyO5/nJKmYZITd5zdUrTLzujgBvfwYmTfuJPvSrceCPYMEFdaj
 4By417MatGrpeiA4FopMdm9eC4Wg/sYkUMsIMXOAWSOa9QT48d+lEb2ImDPxUyN3vDUWvGBXYZ9
 TpY/htXYMrdpkhbzh74OMG8U1WZdBvqjnaXiUm5g2iUKqmjMbY6N7/9zyH96Na/MrnLxrYNGQ55
 293VM8WcO9JzSjW0+iPMvQVST8DeMIDYINJLXweCKiqYptunTWVOUleoEgRnbzzjb9dX/kOr/m+
 rk9y4bxrPUq0fokeivhF65JSAi1wyGpS1LGHPtIMjRQS1beWvjPAXB2a/8Xal46fay7EtbpzTEI
 n3takGL4ioqLSdne40KhZnr5hE2+QBUwewASrlKP+gXNqKK9SMLw2yyn6OcHmpdD+N+4Qe8CHIp
 Jnj5mXXFB1EbElrt3Ug==
X-Proofpoint-GUID: Cf6pq-sRckJMHsiStlj-1Fkn-kxHReg6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_03,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601090079

Hi Peter.

On 12/19/25 3:45 PM, Peter Zijlstra wrote:
> 
> [ with 6.18 being an LTS release, it might be a good time for this ]
> 
> The introduction of PREEMPT_LAZY was for multiple reasons:
> 
>    - PREEMPT_RT suffered from over-scheduling, hurting performance compared to
>      !PREEMPT_RT.
> 
>    - the introduction of (more) features that rely on preemption; like
>      folio_zero_user() which can do large memset() without preemption checks.
> 
>      (Xen already had a horrible hack to deal with long running hypercalls)
> 
>    - the endless and uncontrolled sprinkling of cond_resched() -- mostly cargo
>      cult or in response to poor to replicate workloads.
> 
> By moving to a model that is fundamentally preemptable these things become
> manageable and avoid needing to introduce more horrible hacks.
> 
> Since this is a requirement; limit PREEMPT_NONE to architectures that do not
> support preemption at all. Further limit PREEMPT_VOLUNTARY to those
> architectures that do not yet have PREEMPT_LAZY support (with the eventual goal
> to make this the empty set and completely remove voluntary preemption and
> cond_resched() -- notably VOLUNTARY is already limited to !ARCH_NO_PREEMPT.)
> 
> This leaves up-to-date architectures (arm64, loongarch, powerpc, riscv, s390,
> x86) with only two preemption models: full and lazy (like PREEMPT_RT).
> 
> While Lazy has been the recommended setting for a while, not all distributions
> have managed to make the switch yet. Force things along. Keep the patch minimal
> in case of hard to address regressions that might pop up.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   kernel/Kconfig.preempt |    3 +++
>   kernel/sched/core.c    |    2 +-
>   kernel/sched/debug.c   |    2 +-
>   3 files changed, 5 insertions(+), 2 deletions(-)
> 
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -16,11 +16,13 @@ config ARCH_HAS_PREEMPT_LAZY
>   
>   choice
>   	prompt "Preemption Model"
> +	default PREEMPT_LAZY if ARCH_HAS_PREEMPT_LAZY
>   	default PREEMPT_NONE
>   
>   config PREEMPT_NONE
>   	bool "No Forced Preemption (Server)"
>   	depends on !PREEMPT_RT
> +	depends on ARCH_NO_PREEMPT
>   	select PREEMPT_NONE_BUILD if !PREEMPT_DYNAMIC
>   	help
>   	  This is the traditional Linux preemption model, geared towards
> @@ -35,6 +37,7 @@ config PREEMPT_NONE
>   
>   config PREEMPT_VOLUNTARY
>   	bool "Voluntary Kernel Preemption (Desktop)"
> +	depends on !ARCH_HAS_PREEMPT_LAZY
>   	depends on !ARCH_NO_PREEMPT
>   	depends on !PREEMPT_RT
>   	select PREEMPT_VOLUNTARY_BUILD if !PREEMPT_DYNAMIC
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7553,7 +7553,7 @@ int preempt_dynamic_mode = preempt_dynam
>   
>   int sched_dynamic_mode(const char *str)
>   {
> -# ifndef CONFIG_PREEMPT_RT
> +# if !(defined(CONFIG_PREEMPT_RT) || defined(CONFIG_ARCH_HAS_PREEMPT_LAZY))
>   	if (!strcmp(str, "none"))
>   		return preempt_dynamic_none;
>   
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -243,7 +243,7 @@ static ssize_t sched_dynamic_write(struc
>   
>   static int sched_dynamic_show(struct seq_file *m, void *v)
>   {
> -	int i = IS_ENABLED(CONFIG_PREEMPT_RT) * 2;
> +	int i = (IS_ENABLED(CONFIG_PREEMPT_RT) || IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY)) * 2;
>   	int j;
>   
>   	/* Count entries in NULL terminated preempt_modes */

Maybe only change the default to LAZY, but keep other options possible 
via dynamic update?

- When the kernel changes to lazy being the default, the scheduling 
pattern can change and it may affect the workloads. having ability to 
dynamically change to none/voluntary could help one to figure out where
it is regressing. we could document cases where regression is expected.

- with preempt=full/lazy we will likely never see softlockups. How are 
we going to find out longer kernel paths(some maybe design, some may be 
bugs) apart from observing workload regression?


Also, is softlockup code is of any use in preempt=full/lazy?


