Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC65F439006
	for <linux-rt-devel@lists.linux.dev>; Fri, 27 Feb 2026 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206162; cv=none; b=ICBMEWwtfMN9cEfaRd6w/pInyz2XdUB04hqZk2MWpqcE+/8CicL6U5G7SiE5rxpsEDR+T/K06uS7u5tUbtV/lv9jOXv+ofFaKMZUARIKQqpktFxSsPpVwIT5FBvh1WIzaVhbv1U3VVFq0xfKSf+OSKowa7jJYTwBA3knLZdvwtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206162; c=relaxed/simple;
	bh=nJsPVqry9R4A09Vte2dLq4e2Goo+FpY8IFvWZJvr2W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=szcDtAd00zMBi2FRrmdB0PXtQAT0aU0Cro0xkzLdFbprkxW+JR14vorW4IA4q+yrwPDpc43kTQgriiRmbvmXX7bl3KnOA2KOwiUpsvTO5OA2ApoHKVIGX5g8rAWD5ORQQbOiPH01lMZ9qKZtgAHyfvLhfGp75M62tJoIbBbX/uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PNe+hBD3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PNe+hBD3"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RBY4vv2346142;
	Fri, 27 Feb 2026 15:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=D96HKK
	kKt9opMaXuPzVp1GBtNzvPnjfA8NspN7ab4Jo=; b=PNe+hBD3LG9HwzHUtOpshK
	2eZw+s9JRWT/9slcFXcv42hYii/HeCSNYNy73N9Q3Rf3bcp3Arm5iXq5XcT7o0sA
	S+BDGn6xr8pZaWGdUtZR8RnajhRzz4TYD3taWtOvkqUrY9LZag6P+KSF48QZBuc9
	nBwOzCpc1uwp50Z7zg90YVZ/ehW8GoFofsiG4AdcadPHWN0KrE6FvoZJzYbvchWO
	0MrcC2F0QDrkrS0dkiqjwYK+5S0GROL6TmL9pLCoXGNk5PK0vVMhTCInszhmQE+N
	O4LzLMyVb0V6UZ/ubUgUKZBT3pPSmKuxEH+dyjOm3Lv0WkcSAvNJ63c/GeE28RvQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ch8592s7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 15:28:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61RBaGGP003386;
	Fri, 27 Feb 2026 15:28:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfs8kak49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 15:28:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61RFSbgc30474672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 15:28:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 969B220040;
	Fri, 27 Feb 2026 15:28:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3923F20043;
	Fri, 27 Feb 2026 15:28:34 +0000 (GMT)
Received: from [9.39.16.93] (unknown [9.39.16.93])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Feb 2026 15:28:33 +0000 (GMT)
Message-ID: <b0e30f81-b06c-451b-abdc-ede71fa4a96b@linux.ibm.com>
Date: Fri, 27 Feb 2026 20:58:33 +0530
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
        Nicholas Piggin <npiggin@gmail.com>, sathvika@linux.ibm.com
References: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
 <a86b6bbd-c0ed-40dc-899f-ba162332c80a@linux.ibm.com>
 <20260225105345.GZ1282955@noisy.programming.kicks-ass.net>
 <20260225194809.1f5e44a6@fedora>
 <127c4772-7352-41a8-b30d-8b869751e907@linux.ibm.com>
 <20260226122252.184254cd@gandalf.local.home>
 <97dd1a4f-e524-4337-bcbb-9cbe4bfdda30@linux.ibm.com>
 <20260227095334.40768d0b@gandalf.local.home>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260227095334.40768d0b@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEzNSBTYWx0ZWRfX+XjernRZcurH
 0AjZqAHRU29WTafDUQxfU4JT3gOR9+3/hEds+6cLqcno/b/69h3lVEluPX0c0Nw5CS6xKz/UEUZ
 El7VW9r53MQRS3xKAba9JmcycD6tkHoh09ETrBGuOsl03wSQnkeOYiP9XZShv+bTvd/vWwK+bxU
 eJz33TEDE5NukTWp7GGaRZ6Z8/CD6FSA+PqAi9CG2qaZX8YsQMrHxez2uB1Sr8KhT9aVECPAuDK
 v24gE1/GBa5/j3yxAafQZmxsrX1e3LA4WxQGAqFgjFdnxP+7P5nK+96yGKKX3YIL9ccnvsof/OO
 3D3eAp/EoBLuEaDp4HBVz+oqgcyVt6aaRHi6Um7v+ZcWX2GbqUEN6npwnR0JKgr22QtErKkRu/e
 BJYqWpw6IPJlmr4i7e6FNzBDHKdnnC0IgHjjjiDP8qcXdhJOXo2zNrunko3LTUQxmqtA+HonaV6
 58tWN1XuCa+nbx/ISQA==
X-Proofpoint-GUID: 8zQxxccwEctrSl2Q9p-a42gYVbz4yGAg
X-Authority-Analysis: v=2.4 cv=S4HUAYsP c=1 sm=1 tr=0 ts=69a1b82b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=oz0MBj8qPJYlR2GuimMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -L8JRbTqcWANa-ACoocBd0aEz-Pd2lV9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270135

Hi Steve.

On 2/27/26 8:23 PM, Steven Rostedt wrote:
> On Fri, 27 Feb 2026 14:39:42 +0530
> Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
> 
>> I am afraid we will have trace all functions to begin with (which is expensive), but filter
>> out those which took minimal time (like less than a 1s or so). that would eventually leave only a
>> few functions that actually took more than 1s(that should have limited overhead).
> 
> Well, I think the detection can be done with timings between schedules.
> What's the longest running task without any voluntary schedule. Then you
> can add function graph tracing to it where it can possibly trigger in the
> location that detected the issue.
> 
> On a detection of a long schedule, a stack trace can be recorded. Using
> that stack trace, you could use the function graph tracer to see what is
> happening.
> 
> Anyway, something to think about, and this could be a topic at this years
> Linux Plumbers Tracing MC ;-)
> 

Yep. Will try to do this.

Someone from our tracing team wanted to give this a try too. Lets see.

> -- Steve

