Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C78E26B755
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Mar 2026 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773047626; cv=none; b=NwIx1SVfGl06BQzRJtrX6h2N/++phMHGEEEZav3L4K1apxLhE5vHOY0DApja2eXncQW3yPHHhvnXFmg7bB23OwlmNDK4nLcyVHOCPsPfo3UbxvUEZj+xqQAgD9T0UwI6CEnzH8+TmGx0Ea3aDIHV9qP4/NY+ka4o/OzpoO9ljF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773047626; c=relaxed/simple;
	bh=WMVFDyaFGYEMu+2W51N0zovUrt1bEJzeQcL/YmG5SEw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jstfsihMMNLO0d3kJORlnC82ycj9xXuVBfEOCpoqKFM67HNMQ235pUvuWwEB4RGOcjXiGef/nvNEnc2NHfcoIL5yT1uJr1uC00zIBMh61rInxumO7Qfz3OGuwAdrH3UgaDydvIrmWiv4kelTMDqU/C1LVdWE5hsEZ2v2gmByxog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LYJrWmMF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LYJrWmMF"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 628MlBLF1538857;
	Mon, 9 Mar 2026 09:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZqO+TP
	xuaejMxp3+IXSzDneEAs+DFQQjBDiL+SQuFuY=; b=LYJrWmMF3ko89xdSx38qar
	EK3KHh/jp0E3bx4edTPmWISCAltQ4RupaxzAX+h+854f5KGadR781RbO7UusznZT
	skPD5SS9QcQSxli3BBQP06FV7XAOi8yc5tI7S6eo9vhZMnNYnC1Xh8U7qwyCXjWI
	JvGthaJsQl4qZv3WNf5uwwNeuNWR6xRySEYQ5J+jxoiviiZhVh7LvaUPoiWcC1ha
	gIQoLyG1UhxliQWf/pnRmOOG/wPKsjgC3kjGYWTc7jE/gJ98ISxUOCFBDLqP+PLf
	iXO9no5RUn2AhXn8ti4ObnGnBPc8Tb3ACIdo1sxWCC0Wl5dP2/OQ5EeQWQrF7ppQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcyw5ub4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 09:13:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6295B7vq025041;
	Mon, 9 Mar 2026 09:13:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jjv5ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 09:13:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6299D5Po30671428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Mar 2026 09:13:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33DDA20040;
	Mon,  9 Mar 2026 09:13:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08FF52004B;
	Mon,  9 Mar 2026 09:13:02 +0000 (GMT)
Received: from [9.109.215.252] (unknown [9.109.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Mar 2026 09:13:01 +0000 (GMT)
Message-ID: <05990951-e8f5-4834-9ec0-d54af995ae01@linux.ibm.com>
Date: Mon, 9 Mar 2026 14:43:01 +0530
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Further restrict the preemption modes
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, clrkwllms@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>, mingo@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, sathvika@linux.ibm.com
References: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
 <a86b6bbd-c0ed-40dc-899f-ba162332c80a@linux.ibm.com>
 <20260225105345.GZ1282955@noisy.programming.kicks-ass.net>
 <20260225194809.1f5e44a6@fedora>
 <127c4772-7352-41a8-b30d-8b869751e907@linux.ibm.com>
 <20260226122252.184254cd@gandalf.local.home>
 <97dd1a4f-e524-4337-bcbb-9cbe4bfdda30@linux.ibm.com>
 <20260227095334.40768d0b@gandalf.local.home>
 <b0e30f81-b06c-451b-abdc-ede71fa4a96b@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <b0e30f81-b06c-451b-abdc-ede71fa4a96b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA4MyBTYWx0ZWRfX0QPDrcn1oT29
 ifcKENHNAuo9OxCC4erSe480ZidKJKAAG983TMnrm1RBRkJR1MXMld0+teDyrnYU/OOggOYlvpD
 Z5Lx2CBAZa8n+82v4qfggeih2Zx0NAiv8KEITZoHt+1PAgTSG0W0B+hKTXHDaWEsteBurhm2Ocz
 RCYVgnZ6Rt5VwydsedwMwqz2v1ubBR5wJ3KNd90tWP1POsUl6TEYUIPFrnsZOcw9SSFDfLRyBw9
 Tn4rYcOjZ5my5fHpA81ypmtj+rpDO1WiNSqono17XrPkiSpdbTdKaUtg8SJJbmHwqCvNX5vWubZ
 8sALQXO3qtRLOUPGG5WlwMIQ+/pVrK90fC4TUoSuhSSVCiDnUYFZK7WsYUrRGXbGBE+igjo4F/f
 Pmj0nm4bJdga+aKEEzBYE01O97Wc0jzae/s9VfvOjWiFTo/HPYl/O1NwddCso+3ZIQJoSJQe6dC
 BnHuoyVIpJB13nscfJw==
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69ae8f26 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=oa-y4RgJKXd66vF3O2IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: twl0acA2UnqWat4vdP6N1yLGUvgK2Oeb
X-Proofpoint-ORIG-GUID: IrTWjuhC_u7yWUmbLRjxG4rFkQ4T9BFj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090083



On 2/27/26 8:58 PM, Shrikanth Hegde wrote:
> Hi Steve.
> 
> On 2/27/26 8:23 PM, Steven Rostedt wrote:
>> On Fri, 27 Feb 2026 14:39:42 +0530
>> Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>>
>>> I am afraid we will have trace all functions to begin with (which is 
>>> expensive), but filter
>>> out those which took minimal time (like less than a 1s or so). that 
>>> would eventually leave only a
>>> few functions that actually took more than 1s(that should have 
>>> limited overhead).
>>

It is possible to remove tracing for some function after they were enabled
in kernel? or this could only be done from user by looking at trace buffer?

Even if it doable, This would allow us to trace functions that took a lot of time.
But we should be aiming to calculate the kernel paths that took a lot of time?

>> Well, I think the detection can be done with timings between schedules.
>> What's the longest running task without any voluntary schedule. Then you
>> can add function graph tracing to it where it can possibly trigger in the
>> location that detected the issue.
>>

This would not work either. We will have sched in/sched out even when
running in userspace.

Lets say, user makes a syscall, the process will continue to in R state,
we only need to track the long running time in kernel, but not in userspace.

>> On a detection of a long schedule, a stack trace can be recorded. Using
>> that stack trace, you could use the function graph tracer to see what is
>> happening.
>>
>> Anyway, something to think about, and this could be a topic at this years
>> Linux Plumbers Tracing MC ;-)
>>
>

We could track the kernel paths, i.e different entry/exit points into kernel.

1. syscall entry/exit.
2. irq entry/exit.
3. kworker threads.

For 1 and 2 we have tracepoints already. For 3, we can use sched in/sched out tracepoints
to see if and when it takes a long time.

All of them could be combined in one bpf program. Any thoughts?

Getting stacktrace of 3 is doable i guess, i.e when sched_out happen while in R state and time
check has failed. But for 1,2 getting a stack is going to be difficult.

Please add if i have missed more kernel paths where we want detection to happen.
