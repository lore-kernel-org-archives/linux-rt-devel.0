Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3030A149C41
	for <linux-rt-devel@lists.linux.dev>; Sat,  8 Feb 2025 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739001710; cv=none; b=ctSUvNhFlw01xrp0+p5hxKaCAYyimKHNmJ7ZU2h0iNhwyeN5Lfp/P+P9bKVU6EPS9x2d9lquXetgmqFWUEaEr7y3aK1ARbBISt1NQdwXH2+Sqb0W12qDzYDMnTC8a/4WyWMxM71t88hvI8Z41Ow2FY7OggJ6CThbf5kOspYOdCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739001710; c=relaxed/simple;
	bh=qByOK+vKnmTijqs5GwiZI8SGsGgfVVU1bNLToMIz9SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pTNQn87uXZWMjkPLlFiDs7q7R1hTO8T+LZYs/4Oauad83BfQBx4DIuUJ06/Gyg5rR4jDCDYyUjXPU+zlpDF7GMU2luq6dhsMx4cRzctTfLW4iCmB9YbZzX5N1hqWyK2/L3OBBKyd+R1Ncszx+MX1CGBQaLq/byGE+pFCuX3BQKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vvz26943; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vvz26943"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5187a6HB017462;
	Sat, 8 Feb 2025 08:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vwLFle
	8z8wO4bq1qVCDQZh09gPzGRoCEY2ehD2AcHy8=; b=Vvz26943H4Dr2+EkU/mT4+
	jgMBkUkRG6bFf8jJTS9shyvvrOT6ugXJt6vxl+hQmSLsYTNEsrSf7yeZNItp6reN
	nwNfBxPQw4XGxsvfEEPoOCxd+ITBNlZ/6vHtnzHCEu9+AII5jlLTLYq9Si2u1Nt7
	xTqoRO8EHZZAT3udSTFrO75CipdcbhrUzT3NneR2rgJKuTRndSfmGZ1GNqQY4oW/
	VcVNW9xVTsDG4l14TdFS5A+zSc03nMGjzhLnlngzYZo4jPV0QbRKa4eRhfAYWf8p
	YvlArh6AYp0DAkkGE4D1A8P4gJhftd8PGS9rBAI+3p2GeLc6WVqyvYqK5Hi35a0Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44p2ynr1k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Feb 2025 08:01:37 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51881aXf027901;
	Sat, 8 Feb 2025 08:01:36 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44p2ynr1k3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Feb 2025 08:01:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5185La7Y005292;
	Sat, 8 Feb 2025 08:01:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j05kf3a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Feb 2025 08:01:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51881VwE26673902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Feb 2025 08:01:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D01F2200BA;
	Sat,  8 Feb 2025 08:01:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2E01200B9;
	Sat,  8 Feb 2025 08:01:28 +0000 (GMT)
Received: from [9.39.23.47] (unknown [9.39.23.47])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  8 Feb 2025 08:01:28 +0000 (GMT)
Message-ID: <0d4418ab-d531-413c-bbbd-6c97ea320490@linux.ibm.com>
Date: Sat, 8 Feb 2025 13:31:27 +0530
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] sched: Add a generic function to return the
 preemption string.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: Ben Segall <bsegall@google.com>,
        Catalin Marinas
 <catalin.marinas@arm.com>,
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
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250203141632.440554-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EPJptHoLEpY6kJzKaFTUubVcOttCPjEY
X-Proofpoint-ORIG-GUID: tXWGLHMlr9CxQEQxlLh8GF5Fj2uROFWl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-08_03,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502080059



On 2/3/25 19:46, Sebastian Andrzej Siewior wrote:
> The individual architectures often add the preemption model to the begin
> of the backtrace. This is the case on X86 or ARM64 for the "die" case
> but not for regular warning. With the addition of DYNAMIC_PREEMPT for
> PREEMPT_RT we end up with CONFIG_PREEMPT and CONFIG_PREEMPT_RT set
> simultaneously. That means that everyone who tried to add that piece of
> information gets it wrong for PREEMPT_RT because PREEMPT is checked
> first.
> 
> Provide a generic function which returns the current scheduling model
> considering LAZY preempt and the current state of PREEMPT_DYNAMIC.
> [ The dynamic building of the string can lead to an empty string if the
>    function is invoked simultaneously on two CPUs. ]
> 
> Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   include/linux/preempt.h |  2 ++
>   kernel/sched/core.c     | 47 +++++++++++++++++++++++++++++++++++++++++
>   kernel/sched/debug.c    | 10 +++++----
>   kernel/sched/sched.h    |  1 +
>   4 files changed, 56 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> index ca86235ac15c0..3e9808f2b5491 100644
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -515,6 +515,8 @@ static inline bool preempt_model_rt(void)
>   	return IS_ENABLED(CONFIG_PREEMPT_RT);
>   }
>   
> +extern const char *preempt_model_str(void);
> +
>   /*
>    * Does the preemption model allow non-cooperative preemption?
>    *
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 165c90ba64ea9..bd2664755b09a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7646,10 +7646,57 @@ PREEMPT_MODEL_ACCESSOR(lazy);
>   
>   #else /* !CONFIG_PREEMPT_DYNAMIC: */
>   
> +#define preempt_dynamic_mode -1
> +
>   static inline void preempt_dynamic_init(void) { }
>   
>   #endif /* CONFIG_PREEMPT_DYNAMIC */
>   
> +const char *preempt_modes[] = {
> +	"none", "voluntary", "full", "lazy", NULL,
> +};
> +
> +const char *preempt_model_str(void)
> +{
> +	bool brace = IS_ENABLED(CONFIG_PREEMPT_RT) &&
> +		(IS_ENABLED(CONFIG_PREEMPT_DYNAMIC) ||
> +		 IS_ENABLED(CONFIG_PREEMPT_LAZY));
> +	static char buf[128];
> +
> +	if (IS_ENABLED(CONFIG_PREEMPT_BUILD)) {
> +		struct seq_buf s;
> +
> +		seq_buf_init(&s, buf, 128);
> +		seq_buf_puts(&s, "PREEMPT");
> +
> +		if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +			seq_buf_printf(&s, "%sRT%s",
> +				       brace ? "_{" : "_",
> +				       brace ? "," : "");
> +
> +		if (IS_ENABLED(CONFIG_PREEMPT_DYNAMIC)) {
> +			seq_buf_printf(&s, "(%s)%s",
> +				       preempt_dynamic_mode > 0 ?
> +				       preempt_modes[preempt_dynamic_mode] : "undef",
> +				       brace ? "}" : "");
> +			return seq_buf_str(&s);
> +		}
> +
> +		if (IS_ENABLED(CONFIG_PREEMPT_LAZY)) {
> +			seq_buf_printf(&s, "LAZY%s",
> +				       brace ? "}" : "");
> +			return seq_buf_str(&s);
> +		}
> +
> +		return seq_buf_str(&s);
> +	}
> +
> +	if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY_BUILD))
> +		return "VOLUNTARY";
> +
> +	return "NONE";
> +}

nit: This means when it preempt=full, it is going to show PREEMPT or 
PREEMPT_RT. Maybe that could be put into changelog or add code similar 
to lazy for full as well, so it is easier for user to know if it is in 
preempt=full model. In all other models, there is a suffix like 
PREEMPTLAZY. Dynamic modes looks good.

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

> +
>   int io_schedule_prepare(void)
>   {
>   	int old_iowait = current->in_iowait;
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index fd7e852207157..755232ac88de9 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -244,11 +244,13 @@ static ssize_t sched_dynamic_write(struct file *filp, const char __user *ubuf,
>   
>   static int sched_dynamic_show(struct seq_file *m, void *v)
>   {
> -	static const char * preempt_modes[] = {
> -		"none", "voluntary", "full", "lazy",
> -	};
> -	int j = ARRAY_SIZE(preempt_modes) - !IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY);
>   	int i = IS_ENABLED(CONFIG_PREEMPT_RT) * 2;
> +	int j;
> +
> +	/* Count entries in NULL terminated preempt_modes */
> +	for (j = 0; preempt_modes[j]; j++)
> +		;
> +	j -= !IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY);
>   
>   	for (; i < j; i++) {
>   		if (preempt_dynamic_mode == i)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 38e0e323dda26..fb4486ceb978a 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3619,6 +3619,7 @@ extern int preempt_dynamic_mode;
>   extern int sched_dynamic_mode(const char *str);
>   extern void sched_dynamic_update(int mode);
>   #endif
> +extern const char *preempt_modes[];
>   
>   #ifdef CONFIG_SCHED_MM_CID
>   

