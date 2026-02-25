Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D2A1FE45A
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Feb 2026 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772024195; cv=none; b=AcB6zjXrn8A2mGLsqVCZVHJtWOTnD6Yhq6EvpvbiIf+cJaaZkRXqijmnFc/FjbJtu+6qjg72H8MRp/cPkmlanU0IEh4vGTvY6tCTNtCFwmGPI5annoq9tFCwrTak1pihkMowwqBtktbfjlKLIv2sjbOo69JiWTbk404+Cabia7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772024195; c=relaxed/simple;
	bh=tNwEReZ6mN8B4oMs+vo8hpuGvKaTQQgj75NRqbza4RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULgoUZxKrKQE6KzuB+WMDB7YOXKeT7/+3/t9lgEqzYobhTEetiAMCuC9t8SMKcrNMcUhMPN/k4RqIxJZBRPyPZw62LVuJHwuGaOZYxT8BOVc8fXXetugSOH9zepEJi4Mg/vEf2ZQcX5Jay7iPJU5TRiOOBZkFIyR4h2KZEXqNHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TFmGC4/9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TFmGC4/9"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61ONaY4o2774175;
	Wed, 25 Feb 2026 12:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6gzcXl
	fBinHEyYhYTXjeuQu9UqQoXTj5SbtP9KOv7bo=; b=TFmGC4/9NQYIU37SmyYOCn
	BAAFQTFYmajEC6zSF4z/VhQV9hWuyB6GKjk6XMw5nQfpRpdN90NbxiCShW/AsGgA
	Yc8ZUq1wrY5H3vj1REDP7KatvauYLl32I/hMnpjqX3gIYswBaA6UH1URomF+Y5XE
	lHrHj3i9lRG5QWEcK7FzP/Ojv/nuK/szU098V6efEsd4VdMGoVv/UrxlOXkzHul1
	jLM8QHV5I47iquEtfe7e5Id4FspkREl0f7xXGXGWeWDqUQ82m0KCMj5h3SqfIl6R
	q2yaSMStZyEjB7K5eiDarx8fJiGocsyijfhqC+NpXP/kTJXhJ3hzKR5KqAqu3JJw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34c7hgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 12:56:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61PBfSrs015959;
	Wed, 25 Feb 2026 12:56:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfq1sneqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 12:56:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61PCuBOG45089098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 12:56:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7222A2004F;
	Wed, 25 Feb 2026 12:56:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0CD020040;
	Wed, 25 Feb 2026 12:56:08 +0000 (GMT)
Received: from [9.124.208.53] (unknown [9.124.208.53])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Feb 2026 12:56:08 +0000 (GMT)
Message-ID: <7e43731b-e3d0-4dfe-9517-61891a288e9a@linux.ibm.com>
Date: Wed, 25 Feb 2026 18:26:07 +0530
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
 <a86b6bbd-c0ed-40dc-899f-ba162332c80a@linux.ibm.com>
 <20260225105345.GZ1282955@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260225105345.GZ1282955@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEyMyBTYWx0ZWRfX7wM5UyW+tODm
 A6awB1CorMD/bPSvtkpSvoYNUvxcXwpOMyM9sr5jpa/KKS2Dp8TRtU8r/fdZtilvY3iZjEojS0D
 47j23cfD++IDELc2JLnwJ8QAG2bI58hzuYMXUK31X+cONUOfQJM5l4W7EcrroSUO/05odqsJD/F
 GOFms0J3+WN8vQK5CDaBdkdVoN+rZVHHlT9/jSCT2m4FhGt86O2NI77IGPvQFKzjOZe1M0Lo9yq
 9ZOeZCG528FV9LfRRM+JiBqg5QcHnjVf3A/D3HO2WPInXEW4IcVUoOBLl47lvw8IdnsrbGt8Sjg
 a2te8oV3cQAl8MeYQSapn4dNjln10Qiq+3SlpPS+2zpwQZgBiBjzypwOe4ewWkHTSawhq9D/kpH
 /UvcGkxUm29t1U0tP5toQaUwYJxP02hP67EZliPRlDKiZkaxI8P8ndrJOEw4Z5fUrrki51bVUPO
 fdkzuoExX75mJcGy2gQ==
X-Proofpoint-ORIG-GUID: KAs_nmSiEQKqmfx3VrcjsfAY_pyV7EWk
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=699ef16e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=zY3gc2i7GotqDtDIALgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: tvmFtQ-LBZPCCBvLyW4S3mO2rNFBtw_1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602250123



On 2/25/26 4:23 PM, Peter Zijlstra wrote:
> On Fri, Jan 09, 2026 at 04:53:04PM +0530, Shrikanth Hegde wrote:
> 
>>> --- a/kernel/sched/debug.c
>>> +++ b/kernel/sched/debug.c
>>> @@ -243,7 +243,7 @@ static ssize_t sched_dynamic_write(struc
>>>    static int sched_dynamic_show(struct seq_file *m, void *v)
>>>    {
>>> -	int i = IS_ENABLED(CONFIG_PREEMPT_RT) * 2;
>>> +	int i = (IS_ENABLED(CONFIG_PREEMPT_RT) || IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY)) * 2;
>>>    	int j;
>>>    	/* Count entries in NULL terminated preempt_modes */
>>
>> Maybe only change the default to LAZY, but keep other options possible via
>> dynamic update?
>>
>> - When the kernel changes to lazy being the default, the scheduling pattern
>> can change and it may affect the workloads. having ability to dynamically
>> change to none/voluntary could help one to figure out where
>> it is regressing. we could document cases where regression is expected.
> 
> I suppose we could do this. I just worry people will end up with 'echo
> volatile > /debug/sched/preempt' in their startup script, rather than
> trying to actually debug their issues.

Ack.

> 
> Anybody with enough knowledge to be useful, can edit this line on their
> own, rebuild the kernel and go forth.
> 
> Also, I've already heard people are interested in compile-time removing
> of cond_resched() infrastructure for ARCH_HAS_PREEMPT_LAZY, so this
> would be short lived indeed.
> 
>> - with preempt=full/lazy we will likely never see softlockups. How are we
>> going to find out longer kernel paths(some maybe design, some may be bugs)
>> apart from observing workload regression?
> 
> Given the utter cargo cult placement of cond_resched(); I don't think
> we've actually lost much here. You wouldn't have seen the softlockup
> thing anyway, because of cond_resched().
> 
> Anyway, you can always build on top of function graph tracing, create a
> flame graph of stuff and see just where all your runtime went. I'm sure
> there's tools that do this already. Perhaps if you're handy with the BPF
> stuff you can even create a 'watchdog' of sorts that will scream if any
> function takes longer than X us to run or whatever.
> 
> Oh, that reminds me, Steve, would it make sense to have
> task_struct::se.sum_exec_runtime as a trace-clock?
> 
>> Also, is softlockup code is of any use in preempt=full/lazy?
> 
> Softlockup has always seemed of dubious value to me -- then again, I've
> been running preempt=y kernels from about the day that became an option
> :-)
> 
> I think it still trips if you loose a wakeup or something.
> 

That's probably hungtask report right?
IIUC that would be independent of preemption model.

