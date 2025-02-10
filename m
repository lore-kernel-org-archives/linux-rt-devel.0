Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BB023956A
	for <linux-rt-devel@lists.linux.dev>; Mon, 10 Feb 2025 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208781; cv=none; b=An5Lmpb/4c8uDSzq6NrVTt0QSDmZVRuN9kuFyntgkeC1u2zg6067TTIy3twbqjKR82TTQZ0p+H/cV7/ZsR0O1Ag0DDBQlhQ7HEzpFyGAW19UVcrH3RGEHIzNxKhapZSflG/CnnJ/wes2Eq/KM6r9FDGtJmvnzBaTaT2VmndKu70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208781; c=relaxed/simple;
	bh=0OyYBLRDwLt/cJAndEW9LQGL1foRqsUDW/Fg+WVSk+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MsGVyXlUzGY3zC1uC6+3zP+liu0tNkZXqOcrxU6YJU4V5dHgk+IWa82cbc3dYV0LXTLxHGNLohO10SXH6S1UjMOOkuKoIuR6AAW9LDULwaOUNFfGNDbiX4tN08rnI4Qw5wMCzq21LnIFl0e5Ksd4BhOiaoPYn5gfQ0vjucxZ4BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tHiPL5Aw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tHiPL5Aw"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AB362O016388;
	Mon, 10 Feb 2025 17:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kYyrFW
	YbzGdMrqABOt2hlSYtOyka49+cboKRHeEWiRU=; b=tHiPL5Awh120VosYGzER6Z
	19B0U8TW48reM0F3f1hjCA80wk9fWTYJ/B01vbmi4Lo/D6mGAfmzVGKr4qT9wojt
	OFgu3SWKBF84uFhp2zUW0V26LGvk/U4tIqtBwIa7NhvmlQ8EyK+/BU++Io0sTt9N
	orN54TrDo+X5F/9g7F+ldj1iwXNabPfpMFJwZXJ3FzE4R1lgnjWzmfskP3yeuegH
	78hUKxp+fZJJwAiZETDiJJ4oSkWstd+82V1aGE2OyAb2RYNCyu9u5qK79HZnlhCU
	RykX4Lhx6Rg7QXJhOgXgXAa/ztCWVVAcrLKa3xw8OgKxYU26Zw1EkFppumemjDTg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44q5gacrt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 17:32:22 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51AHGnjS027352;
	Mon, 10 Feb 2025 17:32:22 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44q5gacrsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 17:32:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51AHJE3A028735;
	Mon, 10 Feb 2025 17:32:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44pma1f2dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 17:32:21 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51AHWJiJ29295064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 17:32:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E16320043;
	Mon, 10 Feb 2025 17:32:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4664520040;
	Mon, 10 Feb 2025 17:32:15 +0000 (GMT)
Received: from [9.39.21.225] (unknown [9.39.21.225])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Feb 2025 17:32:15 +0000 (GMT)
Message-ID: <f4d1805b-e28d-4371-a7bb-cca55efe4854@linux.ibm.com>
Date: Mon, 10 Feb 2025 23:02:12 +0530
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] powerpc: Use preempt_model_str().
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        Ben Segall <bsegall@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Deacon <will@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
        linuxppc-dev@lists.ozlabs.org
References: <20250203141632.440554-1-bigeasy@linutronix.de>
 <20250203141632.440554-6-bigeasy@linutronix.de>
 <65c6f60d-bb52-48bd-a02c-87ffd2a915d4@csgroup.eu>
 <20250203160103.9DikC9FJ@linutronix.de>
 <51999b8e-61c0-48b7-b744-c83d39e7f311@csgroup.eu>
 <20250204082223.6iNyq_KR@linutronix.de>
 <7b51f7de-8e4b-4766-85ca-dee24832c693@linux.ibm.com>
 <20250210105949.b9PKqiw7@linutronix.de>
 <20250210142327.bCujH28L@linutronix.de>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250210142327.bCujH28L@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ez6cL0fY6xcj2Nh_3tBWUALCegRkBZNy
X-Proofpoint-ORIG-GUID: SJVbL5SwI_xYJLjBpcKAs46Hby7dReIy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_09,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502100143



On 2/10/25 19:53, Sebastian Andrzej Siewior wrote:
> On 2025-02-10 11:59:50 [+0100], To Shrikanth Hegde wrote:
>> Thank you for noticing. I did remove it on other architectures, I
>> somehow missed it here. Will remove it from from the arch code.
> 
> This is what I have for powerpc now. I'm going to repost the series,
> currently waiting for arm/x86.
> 
> -------->8-----------
> 
> Subject: [PATCH] powerpc: Rely on generic printing of preemption model.
> 
> After the first printk in __die() there is show_regs() ->
> show_regs_print_info() which prints the current
> preemption model.
> 
> Remove the preempion model from the arch code.
> 
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Naveen N Rao <naveen@kernel.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   arch/powerpc/kernel/traps.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index edf5cabe5dfdb..cb8e9357383e9 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -263,10 +263,9 @@ static int __die(const char *str, struct pt_regs *regs, long err)
>   {
>   	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
>   
> -	printk("%s PAGE_SIZE=%luK%s%s%s%s%s%s %s\n",
> +	printk("%s PAGE_SIZE=%luK%s %s%s%s%s %s\n",
>   	       IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? "LE" : "BE",
>   	       PAGE_SIZE / 1024, get_mmu_str(),
> -	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "",
>   	       IS_ENABLED(CONFIG_SMP) ? " SMP" : "",
>   	       IS_ENABLED(CONFIG_SMP) ? (" NR_CPUS=" __stringify(NR_CPUS)) : "",
>   	       debug_pagealloc_enabled() ? " DEBUG_PAGEALLOC" : "",

Looks good to me.

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
