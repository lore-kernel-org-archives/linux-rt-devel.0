Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7488F2528EA
	for <linux-rt-devel@lists.linux.dev>; Mon, 10 Feb 2025 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739197315; cv=none; b=kbYgc3OmmQbMuDhif/yptBTGjlXrCXXd80q7GpuJZHVt7FoO7GCPJ0NoE2KLPqJxyhnw5yniYxien6oqdxgeEZatljOxBNbB3cCQ3udhotWlG6LGSl0OARpBAKWb7ZuVU+vrC1VysG1azvoIo54aydjsejuzG44L5uST7kRkfiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739197315; c=relaxed/simple;
	bh=QjyhJqVWK/aPIScXin0laTxOCQ4c2W8JoxFkjlYRIFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDbpcxC2NORsrRxdLFQCpt9uPBjM1HXMgDNmjR83vxT+o0EGWRJQd9kh3y3BPtJuTn3URFXdVdRU+4SWcMrmXhIUzLIaIvwPq9+7DPAQmao5ZYHeLshR93FFpT7QUpAaPi8W2/4iWTXKQ9+Sc9gy45pWkx2FbVMgfbet/gxUo5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CtEG8q1M; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CtEG8q1M"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A9VON1016561;
	Mon, 10 Feb 2025 14:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vjf1sv
	eKhz5pPyQoZkv531CSkARpadTwoJqnin4mwiw=; b=CtEG8q1MhORLTtDT5ojIHp
	gA6pF4iaxSS1jfG/0jraIPGK/bOM4jozX5pgricOCiAFDUT59yDZymeBer+Gjl+J
	Kby+FZlIMCOY31gL4XcPGu4XXfc1kMXcDBntN2g4DoTFMWqfJl5XiRbUOx0n1gGq
	yNj8+RWzwdTQio97IrKcF/kkAMsCxtfk2FUBSzEsabpXOvLoazc4p2nLpXZy23Lz
	mOsqzfZyTTw9Z8wSHr4VxlVTXJj45Jd9vS5Is2CgbbAhCH5iN+RyxU+n0KgnaTcn
	/chMhx5z1jrew/NrXP2GHzaDk7V4b24Afq2lXXUfdE4WjeyL6sjST5NBWbKNdGGQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44q5gabqan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 14:21:40 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51AELe3C019614;
	Mon, 10 Feb 2025 14:21:40 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44q5gabqac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 14:21:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51AD3smc011642;
	Mon, 10 Feb 2025 14:21:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44pktjpf5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 14:21:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51AELbsD51249480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 14:21:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63FDE20043;
	Mon, 10 Feb 2025 14:21:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BB7020040;
	Mon, 10 Feb 2025 14:21:34 +0000 (GMT)
Received: from [9.39.21.225] (unknown [9.39.21.225])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Feb 2025 14:21:34 +0000 (GMT)
Message-ID: <b7740edc-ea89-488d-9d6e-d31f5f1dcae1@linux.ibm.com>
Date: Mon, 10 Feb 2025 19:51:33 +0530
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] sched: Add a generic function to return the
 preemption string.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        Ben Segall <bsegall@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Deacon <will@kernel.org>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
 <20250203141632.440554-2-bigeasy@linutronix.de>
 <0d4418ab-d531-413c-bbbd-6c97ea320490@linux.ibm.com>
 <20250210105240.FTbUbs_F@linutronix.de>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250210105240.FTbUbs_F@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F-R08ScM8UqN57hodzPSl_Ux_Kea7wU7
X-Proofpoint-ORIG-GUID: dnOxxI9ICMWYA4Pr_rx9x-6HU1yIqJVj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_08,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 suspectscore=0 mlxlogscore=563 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502100117



On 2/10/25 16:22, Sebastian Andrzej Siewior wrote:
> On 2025-02-08 13:31:27 [+0530], Shrikanth Hegde wrote:
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index 165c90ba64ea9..bd2664755b09a 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c

[...]

>> nit: This means when it preempt=full, it is going to show PREEMPT or
>> PREEMPT_RT. Maybe that could be put into changelog or add code similar to
>> lazy for full as well, so it is easier for user to know if it is in
>> preempt=full model. In all other models, there is a suffix like PREEMPTLAZY.
>> Dynamic modes looks good.
> 
> Sorry, I can't follow. With PREEMPT_RT enabled, it will show einer
> PREEMPT or PREEMPT_RT. It will add lazy if you pass preempt=lazy. It is
> either 'full' or 'lazy'.
> You can't have VOLUNTARY+lazy or VOLUNTARY+RT.
> 
> What do I miss?

No No. That's not what i meant.

I was saying, as peter mentioned in the previous discussion, can we put 
something like below in changelog/comment for a easier understanding.?

"
RT+DYN:	 PREEMPT_{RT,(dyn_mode)}
RT+LAZY: PREEMPT_{RT,LAZY}
RT+FULL: PREEMPT_RT

DYN:       PREEMPT_(dyn_mode)
FULL:      PREEMPT
LAZY:      PREEMPTLAZY
VOLUNTARY: VOLUNTARY
NONE:      NONE
"

> 
> Sebastian

