Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978551DF258
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Feb 2026 05:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772083870; cv=none; b=shkceulT0f0WkS5umJtDTgcyRItfzkxiBfM1RDU9q9P2cYOwlN5ILdNbseujyh/P328Gyds8DVYcDAON4AWtDhKI7HOeByQrL7KQu9QEoiBDJYaJY5uUi2/MZXib7h2RAf5lyRpZLzdaPtH4ucOAS/UIPlGWmFzSjN85JBP8g3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772083870; c=relaxed/simple;
	bh=xc+4CX+qp8mgmG+r6GhoZUC2QB3Yxa+BqEdJxI7BoNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsdTEBd99V8Eviq2XLCEXsfh1kI+UlDEHw3qkSttxac5EmFVeCNcD9etf2seHM+jVnESKFk75UcUZXRQ0AJ0pS1DXdegljeZROvDLORq91Woam4XdzmBCFYuVbETY3DdlL9n7b5ekFeHOP+RqazRaNEkDaOH6TEJnS45YnjKays=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qDNpFrQJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qDNpFrQJ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PLOKuJ2347127;
	Thu, 26 Feb 2026 05:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OWVwv+
	41TbhvHmOcDHXan7f8hXdGZcKnSvlJiowiL+M=; b=qDNpFrQJB5QxJGUgA7MfKA
	7e16Dtz9ULaEo2f60hPNUnVV3kGTWUC2O14lMqyE/W3xwJplDLEMwB+zlB/rBfbb
	khhAGam7nfH9se2d5+sr4OxiN902udsMsRqFTrAiG1qdfcGi+7G3IbSZYpGye7hm
	XVFjXTCEilAb3F9vyVnd95U/fr7rsD1Lxd9jvQMj/cX0b1vDElr7asdVmgs+e1gK
	ajaS9ZSbI+HpzxH7Y6Ng9lS76Crzu/F//BaVHdXyO+zKmHthulkVJfl7sACV7Xqy
	r5dWsUnpx7Q+GOxcEvbZ6RWScF8CzHQDq4qEYN9iKlV6oi2qNRUFuhmm1+5Gz3CA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ch858sunm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 05:30:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61Q2Hfx0015970;
	Thu, 26 Feb 2026 05:30:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfq1sshpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 05:30:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61Q5UJff33751500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 05:30:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7883320043;
	Thu, 26 Feb 2026 05:30:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC94B2004B;
	Thu, 26 Feb 2026 05:30:15 +0000 (GMT)
Received: from [9.109.215.252] (unknown [9.109.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Feb 2026 05:30:15 +0000 (GMT)
Message-ID: <127c4772-7352-41a8-b30d-8b869751e907@linux.ibm.com>
Date: Thu, 26 Feb 2026 11:00:14 +0530
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Further restrict the preemption modes
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
        Nicholas Piggin <npiggin@gmail.com>
References: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
 <a86b6bbd-c0ed-40dc-899f-ba162332c80a@linux.ibm.com>
 <20260225105345.GZ1282955@noisy.programming.kicks-ass.net>
 <20260225194809.1f5e44a6@fedora>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260225194809.1f5e44a6@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA0MyBTYWx0ZWRfX/nC/pzm6kQYo
 mRVeBLkZiZjuKQafnp6+UTZMpGDGRr6cZUbTvkqjDDoNTiUpNLb/elpMEzodaNLKuic4SBvWS3E
 yjmTPaexjBA1T6YqF2yXAg/3CAep2g4nNHcgDNBlHy8M7S4kxoB0C8XjWdGWobYse+tDjh69qjo
 pOPrAFhI5hL/DGUwJMgwqB8TakWsfixStov3Tth3Bn/SaGphVl+NgyB06qEQiWQHtZyvncJZhh4
 0cbqyyhNlYdJsTlEmJO8R2MK7fWXUk14TlFGGifC/SIqIskBFZML66Jvv9CXejv2I6Bxt9eSvST
 FDtfRhp7X9MpEUDWO4MDeB1AMwAggsPj7vY2AdNkCTjI8lBlfhX5YZqmEJ9mxmFVTVF8oILyyHZ
 QyI80xI+XO6p1JqNs5tH1WtJdD34XJqrz/v/Ii96U9RxOpwBhMig0KxSx+MCw098QmCvZayexcf
 +ipQCPtstQYsbFetiTA==
X-Proofpoint-GUID: yBTpFzr8I5mCOZciXgpQwg3wQqVLjfGV
X-Authority-Analysis: v=2.4 cv=S4HUAYsP c=1 sm=1 tr=0 ts=699fda6e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=JfrnYn6hAAAA:8
 a=9KQTSeBl8QLHg7aGaK0A:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: rFXzicFche5BpMbBsUvVXrwQpFYcQBSK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260043



On 2/26/26 6:18 AM, Steven Rostedt wrote:
> On Wed, 25 Feb 2026 11:53:45 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> Oh, that reminds me, Steve, would it make sense to have
>> task_struct::se.sum_exec_runtime as a trace-clock?
> 
> That's unique per task right? As tracing is global it requires the
> clock to be monotonic, and I'm guessing a single sched_switch will
> break that.
> 
> Now if one wants to trace how long kernel paths are, I'm sure we could
> trivially make a new tracer to do so.
> 
>    echo max_kernel_time > current_tracer

That is good idea.

> 
> or something like that, that could act like a latency tracer that
> monitors how long any kernel thread runs without being preempted.
> 
> -- Steve

With preempt=full/lazy a long running kernel task can get
preempted if it is running in preemptible section. that's okay.

My intent was to have a tracer that can say, look this kernel task took this much time
before it completed. For some task such as long page walk, we know it is okay since
it is expected to take time, but for some task such as reading watchdog shouldn't take
time. But on large system's doing these global variable update itself may take a long time.
Updating less often was a fix which had fixed that lockup IIRC. So how can we identify such
opportunities. Hopefully I am making sense.

Earlier, one would have got a softlockup when things were making very slow progress(one's
which didn't have a cond_resched)
Now, we don't know unless we see a workload regression.


If we don't have a tracer/mechanism today which gives kernel_tasks > timelimit,
then having a new one would help.
