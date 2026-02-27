Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2478F36CE03
	for <linux-rt-devel@lists.linux.dev>; Fri, 27 Feb 2026 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772183422; cv=none; b=KT4XfnC/ICnxCwYoallQ3zsz9HbdDXVZICn1ySFv1ZRel52y1JDCx2Hi4sz0W1tEu/DxMKUtOVztL0ah55ZEIavS5/OeZSOYk+IRebyfCcImFI9SPLRBzG9RW/uFqmp5DWMf5ieNW9iPQi/wqbI5gN9l2PUkixqBQaM7Bq0sjnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772183422; c=relaxed/simple;
	bh=XOxkwXTAcP805Ikm0PXfQ2fivcadHjMNdowdstLj6uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J01LhcEatxNq16qdhflKNiUG+WrhV4l8dmvaicVC1ceUvV5MA2p+iW3ZsEYjxUO0ezCo5b0THtZ1FRhByn0aic8SqbVatlHw8OIwKUIsqEokkxb083FCNRy43kE6qnsGINeifbq5KAc9+qGz/+e5Pn+eAH2xbPWesXYNW8M9C3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GG+AMi7r; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GG+AMi7r"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R3wN762757298;
	Fri, 27 Feb 2026 09:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Q6GcSJ
	BpmsbjTyv+uCcJY72o0UYIG4L2UaTPv2HIYmk=; b=GG+AMi7rhOa6uDnvl1mZ2A
	oUkTIO15GLEg2ht/NzRiPSQRhG01yxSaBBKB5k9ez68+fD1vNjS4M10tbL6QZ1Wc
	FqLeAmn+yZsXo+/ZRb9ohPzYCh4cyd7QcYLIyeZ2CDdCToFjxogDpDUdRMC30aiI
	qqyuvIvPFgJtZQNrCuv2d6tBLP5nLoLeN4T0CQcLvsxRcUPEXcyQkWt5Zb3wyf16
	/tsEjf789Dr96I1PaKTHitM/LO+7emd7cdrZfZpMeghnH2iboMEr4vtDsRVprpTY
	hhSMYETZ5P7oiPsgAN/Nqx49GOVXSCQAWpSxWgmx9Dlvj6+tmpbuDB3E8c2VgFnw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf24gu2qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 09:09:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61R8XCrm003821;
	Fri, 27 Feb 2026 09:09:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfs8k928c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 09:09:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61R99jOx55443802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 09:09:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0A6920043;
	Fri, 27 Feb 2026 09:09:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0430B20040;
	Fri, 27 Feb 2026 09:09:43 +0000 (GMT)
Received: from [9.39.16.93] (unknown [9.39.16.93])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Feb 2026 09:09:42 +0000 (GMT)
Message-ID: <97dd1a4f-e524-4337-bcbb-9cbe4bfdda30@linux.ibm.com>
Date: Fri, 27 Feb 2026 14:39:42 +0530
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Further restrict the preemption modes
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
        clrkwllms@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>, mingo@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>
References: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
 <a86b6bbd-c0ed-40dc-899f-ba162332c80a@linux.ibm.com>
 <20260225105345.GZ1282955@noisy.programming.kicks-ass.net>
 <20260225194809.1f5e44a6@fedora>
 <127c4772-7352-41a8-b30d-8b869751e907@linux.ibm.com>
 <20260226122252.184254cd@gandalf.local.home>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260226122252.184254cd@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TNRIilla c=1 sm=1 tr=0 ts=69a15f5c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=JfrnYn6hAAAA:8 a=hzceDJMGHZs13yksoFUA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: TLfxzvOZW23J3ZBIvrJ57ObM_VYdbYB5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA3OCBTYWx0ZWRfX3AxVO1HdmLES
 oMxSb2rA/5JCLUoc864yGVBeivhp3ggb1niOSivPP4PiYSi0xdgfK/1STInEL/VKSEbiqT6PgLj
 QUyUjdBP5wo/rNdks0kLgevLIfJyxagsebvmsXN75Y6ItaY3i5Gr5nZ+Ezm3W0+H57kHVCLw3MS
 cwrAW9hYdToi4APy/s5+3x0dzq7aXpNG69ALF+tpEFPQYxbW4bfkex2noHdPA8mny2BOJxdmzNY
 IdxQ4diIibHsFIvZ+Hug/YaYcT/b4YWYFhJMAUk8VfVue35vANhD3NAIZKHnPD6hOrlGy//PvdD
 q7bdwbr4COL+QhGGI2rLyGgy8ulN50FgcHfkxay4C+7KkDYlA5FyXVPJTQWPK1tDb+qVAZ0Kxra
 5B3I0B2wxRPhm6ac093fvWX885WjEca7dCO8Lto37NA+meDSy3hfmn4MB6xTIXrTCJh9z88jOAG
 TMhohKa3tuOydrxxn5A==
X-Proofpoint-ORIG-GUID: 7sGLj4W4zqcDtqS8r3PS-BTw8yWelfmg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270078

Hi Steven.

On 2/26/26 10:52 PM, Steven Rostedt wrote:
> On Thu, 26 Feb 2026 11:00:14 +0530
> Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
> 
>> On 2/26/26 6:18 AM, Steven Rostedt wrote:
>>> On Wed, 25 Feb 2026 11:53:45 +0100
>>> Peter Zijlstra <peterz@infradead.org> wrote:
>>>    
>>>> Oh, that reminds me, Steve, would it make sense to have
>>>> task_struct::se.sum_exec_runtime as a trace-clock?
>>>
>>> That's unique per task right? As tracing is global it requires the
>>> clock to be monotonic, and I'm guessing a single sched_switch will
>>> break that.
>>>
>>> Now if one wants to trace how long kernel paths are, I'm sure we could
>>> trivially make a new tracer to do so.
>>>
>>>     echo max_kernel_time > current_tracer
>>
>> That is good idea.
> 
> Yeah, I think something like this should be added now that LAZY will
> prevent us from knowing where in the kernel is really going on for a long
> time.
> 

That would be the goal.

>>
>>>
>>> or something like that, that could act like a latency tracer that
>>> monitors how long any kernel thread runs without being preempted.
>>>
>>> -- Steve
>>
>> With preempt=full/lazy a long running kernel task can get
>> preempted if it is running in preemptible section. that's okay.
>>
>> My intent was to have a tracer that can say, look this kernel task took this much time
>> before it completed. For some task such as long page walk, we know it is okay since
> 
> Tracers can be set to only watch a single task. The function and function
> graph tracers use set_ftrace_pid. I could extend that to other tracers.
> Hmm, that may even be useful for the preemptirq tracer!
> 
>> it is expected to take time, but for some task such as reading watchdog shouldn't take
>> time. But on large system's doing these global variable update itself may take a long time.
>> Updating less often was a fix which had fixed that lockup IIRC. So how can we identify such

That was a hardlockup. wrong example.

>> opportunities. Hopefully I am making sense.
> 
> Not really. Can you explain in more detail, or specific examples of what
> constitutes a path you want to trace and one that you do not?

All I was saying, there have been fixes which solved softlockup issues
without using cond_resched. But seeing softlockup was important to know
that issue existed.

Some reference commit I think that did this;
a8c861f401b4 xfs: avoid busy loops in GCD
e1b849cfa6b6 writeback: Avoid contention on wb->list_lock when switching inodes
0ddfb62f5d01 fix the softlockups in attach_recursive_mnt()


I am afraid we will have trace all functions to begin with (which is expensive), but filter
out those which took minimal time (like less than a 1s or so). that would eventually leave only a
few functions that actually took more than 1s(that should have limited overhead).
