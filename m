Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AAF1953BB
	for <linux-rt-devel@lists.linux.dev>; Sun,  9 Feb 2025 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739111952; cv=none; b=gsz6rQfB/o75oRbHKjZDEJxG+BSPOeR0hDaAe3WNn3dh6hbluNbc2f17MPG1sT6C7IcfIfWf50Ito9dTwImtlOdYWeEq7oyYA6AHjV/okqG5mSCqbRxS+mEa/S7LEwJ4apojapxmgjN70m80ZAjFHMz9DcDOJtQ9hXFuv6m92+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739111952; c=relaxed/simple;
	bh=hhR/RtUoK2ytKbwGIfxhqKLa0YYXGaKY9uX6/fPki1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=evUa9blQ/c0MfuIYMitZogkdfkNrTCrY4EWFN/XI6UWV3ZcnujwY8UxuzBZwqTNej4ocGw4iv95ltntcnh9sg1gpZwWrGTDcUS4vdKKyccOeCIEXd0n2ZYa+fRZkS6tfgc0OXmTZVpK6RysMma2pd83p13LlWyPJifwd7pHR6Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NGu9TdLK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NGu9TdLK"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5195QDCC010826;
	Sun, 9 Feb 2025 14:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2jJ99p
	3gLYXnRSW9YGZWpj3nvszInWZX+GpPE9chr/U=; b=NGu9TdLK4I8Jo2pvuw7EEL
	SQIJymOI4fKypV4OcXvHNHAD+NpFNHTTpl0tr+a+0TfJTVJzfGAaKodTxcnTw+on
	bbaPHdu0hOsb76RrvLBA+KT3fye1CZftfxbjVWd/Y4MA+5Kl+UwtWoTyja5m+et0
	peyNAJYu7DsC5YwGurp486Bwj5QY+oXjVj24vT1R05YfdXzq2rC0K19z2NXonl44
	Os9Wdwau23Xu6+TkCMoun0z9Aq+38dKhY9GULTK5EvGs4Roqw2Uj82ZnyVGtqsDP
	jXLD1Du5vkQ1xOP8RdtBPDNB3lqchgGeirJP4JuhOhhWrrVL3lYRqJDY5L9bQ4zg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44pp67hfwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Feb 2025 14:38:31 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 519EcUv3004071;
	Sun, 9 Feb 2025 14:38:30 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44pp67hfwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Feb 2025 14:38:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 519DcD2D011605;
	Sun, 9 Feb 2025 14:38:29 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44pktjhw51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Feb 2025 14:38:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 519EcSZ859703558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 9 Feb 2025 14:38:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0014B200B2;
	Sun,  9 Feb 2025 14:38:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9983D200B1;
	Sun,  9 Feb 2025 14:38:23 +0000 (GMT)
Received: from [9.124.217.6] (unknown [9.124.217.6])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  9 Feb 2025 14:38:23 +0000 (GMT)
Message-ID: <b95272d4-e593-48e9-aa32-8758394f4b61@linux.ibm.com>
Date: Sun, 9 Feb 2025 20:08:22 +0530
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] powerpc: Use preempt_model_str().
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
 <93833119-9406-4d30-aa7b-4521adb3a573@csgroup.eu>
 <936f0451-a4ee-4e14-9ce9-9cd9613fc55c@linux.ibm.com>
 <0f05c020-47e4-444d-90ab-9eb8414f4ef8@csgroup.eu>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <0f05c020-47e4-444d-90ab-9eb8414f4ef8@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ahxagrRhUTbQ2SnBv_lVtX3SqDwYyVyh
X-Proofpoint-ORIG-GUID: L1TXmrNEGNXOItYXtK_GBjElbDfLrPaS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-09_06,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502090128



On 2/8/25 23:25, Christophe Leroy wrote:
> 
> 
> Le 08/02/2025 à 14:42, Shrikanth Hegde a écrit :
>>
>>
>> On 2/8/25 18:25, Christophe Leroy wrote:
>>>
>>>
>>> Le 08/02/2025 à 08:35, Shrikanth Hegde a écrit :
>>>>
>>>>
>>>> On 2/4/25 13:52, Sebastian Andrzej Siewior wrote:
>>>>> Use preempt_model_str() instead of manually conducting the preemption
>>>>> model. Use pr_emerg() instead of printk() to pass a loglevel.
>>>>
>>>> even on powerpc, i see __die ends up calling show_regs_print_info().
>>>> Why print it twice?
>>>
>>> I don't understand what you mean, what is printed twice ?
>>>
>>> I can't see show_regs_print_info() printing the preemption model, am 
>>> I missing something ?
>>>
>>
>> Patch 2/9 add preemption string in dump_stack_print_info.
>>
>> __die -> show_regs() _> show_regs_print_info() -> 
>> dump_stack_print_info() -> init_utsname()->version, 
>> preempt_model_str(), BUILD_ID_VAL);
>>
>> Wont we end up in this path?
> 
> Indeed I missed that. You are right, we now get the information twice:

I think we can remove it from arch specific code and rely on lib/dump_stack?

And similar concern of printk vs pr_warn/pr_emerg would apply to that as 
well i guess.

> 
> [  440.068216] BUG: Unable to handle kernel data access on write at 
> 0xc09036fc
