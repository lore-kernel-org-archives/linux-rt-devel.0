Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9062732BF5D
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Apr 2026 06:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775112739; cv=none; b=YssQVz01hHfE/PdGGh29pJiijn88QKku2kbq0du3FLqW5h9IGWY96sJDc5FW9A6l6q81+23l/r6INvTw9vLj9uo27nqmq4Xu4aZI2eY3unzVNfkk/yKNAA3K4fZKVx2RTmZLTQ2w6sFMYm8YmHaquPtyV0aY224G14iZ9cedG8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775112739; c=relaxed/simple;
	bh=xRrX7+ChFARFJjvSnOyf/XVz+ekF01zG2RHavVcSjLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rIU2BPDIr/p5fowxGcHW+YCbQy6Q6Hol6cxh/7CEwLH+2tKlQizBPgagA5Kg7U3XxcWfuTHMfPtney7dvmjY6Zlb2DFc618BdlgClitPxPj+d3k1fmblpKKfEyRt1L1R8RZWsXw6BDm3gS4qWltGsu889hCyssbH+ZmwSNKY6Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BRPEIKaR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jGrdYlpE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BRPEIKaR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jGrdYlpE"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6326mk7n3956007
	for <linux-rt-devel@lists.linux.dev>; Thu, 2 Apr 2026 06:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jTYcWIhFz0PjRYqf7rrSJdqYU6hbKED5h78gJAgGLmg=; b=BRPEIKaRTCfFaUaC
	OSajXchS1lk7vuYD7ZNHbkhCC5Qt+2bGMYDL3udopUGNXJOsTN2t8df8g3pFgLkP
	JVTIiqugaIiY74yOjlav/LH2su0hNn8v8PQto29aifYvS/OJUkPA/4orQvTwYpGR
	AXlr06HPcX2udTCTYJVw5pL/rgUAvpfG9kXCC+h9u3dUJy0/w6P1+DasYEVWUBl+
	0R2vMc8NomO+KhtS1VZVMCzbM4OPwxV9a+0pM9HPgiIwgat84XrvcFwu3KzwRy11
	Kp1MkffG/6HnSU85nXK88KWYFusvVZ3EnEKtchZYx2jHeMhO0PxPV0Fy7PQaY/wA
	W69BYQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9aw5hsgv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Thu, 02 Apr 2026 06:52:16 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c76b06f37a7so226377a12.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 01 Apr 2026 23:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775112735; x=1775717535; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jTYcWIhFz0PjRYqf7rrSJdqYU6hbKED5h78gJAgGLmg=;
        b=jGrdYlpEiDhXukpjF32FURSsa/B/67ffMlZEHNHSOECKVQOJb/oZg6cgaurfGAd873
         JiND/T2skGgT8vHxG9ncmJ2kVw/AT4qF9om/ulUfWtjAg0g352NMoeoBXjlTKKTFw+eJ
         bfqswhcwGXlBwXfMmCUni7Z6JPfp9y67H8JWU4kuTqQAQPajrqEn+KgrpjJuNev2S8Ph
         C9n5YnI0om1ci6kYduv0kMD2518W6xD2SRKVf+Yv3xynIT6Gopx+v5De5mRjn5VuOEbV
         3yW+qU3kHYmIFz5CqtEwSqpbzOzQ79KKqMdJwQbHzApkbVe+TNdA1GwHG8KbIvWbaKLj
         KIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775112735; x=1775717535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jTYcWIhFz0PjRYqf7rrSJdqYU6hbKED5h78gJAgGLmg=;
        b=Nwy2sBCaMNCt3zkRNxxalN3AqjabhJY1p8WEkjopImD57Kb6+AaaXRAEYiqAgn1/Ed
         q5No7OwMHngPuu7jCzLxv5qZLUK53qzG4ikVq+1zp5kDMUXg7RAxaxj9iHAg2GK2whob
         wrm7em3JjeDaTfP6XDGy/dWJ4VWX3z1NHd0D8ZCu09xHcT8UCakjf1szGxuYV91coS/u
         0id08sR5D/MHcjPWFHv067cw8Dj+mD8+5dIxGunXLNl00otEtadz67poSL5gaELOi+/g
         wyYRiVQNwgzXQ5bUFvWtKLSe2FQl4ocd1eM7/ANEE2x94JIdGCGY42rZzEWYvpFpVhGN
         D3dg==
X-Forwarded-Encrypted: i=1; AJvYcCWCfonJjsVlb+d15rVlh8rIUpO/4/9Lop9yNwBHJsJy/cLSx24AFzk+tO8VyebTqGlICgSQLFl8vyHE+uw0RA==@lists.linux.dev
X-Gm-Message-State: AOJu0YymdE1LExS0Cm7RvJNCL7+tdf1HScH8R07JyLNIdcANu4dDScbP
	SDEt4MDWxG/GVzUVBl5s8Wdc2IWvtAek+sl3KDylYTZECPLdtwytF5iklIrRLLzflvrcofIN9WK
	0ubg1fpu6lfPa9Xq8+D+HXWrPH/99UBYhHF8b5EcU28tZhnw6D39nyfkc6JuQf+XCQY7xYg==
X-Gm-Gg: ATEYQzxNFKjDDF/W/FqaFr3WHB0h9pEoQ2WVG4p3R0pGpNmytdG8s75JKWUkDORf/h0
	S4XdNPp6H8WJ4KyTGvtHJqLpZuiGjEnW9d87J9xR8jfIEtp3LGhLXSS5YZq8/hzxTv6GzPYGW8d
	1i7y9+/sZ0RvaMp8AuroPMoq8v3Or1syIZedAGrwjaNXbNRloUQBQ547IFvb7Ihb11PTpcjnoP0
	R+Dn2hUnOoX1FrjKG53tr8F93SKOEUlr+AykByIJOe5jLCW0gAwQue2VpqP9knV+Stl2wxuqeyk
	G7OjFxQbxhOi9//+nAq9vkkYs+MOqrDBR1v3t5y6gwamJqYfTydv8dnwqC8Hro2zS7rW74ywABq
	hrV4H3SzqsV/LsTrO8iidvjgkoQMs5dw4awzvnbecA3OYh8aLRfSJ7Oj3M+uS8rrC+1miY/mTuA
	/+hr9RABslVPMz6izukQ==
X-Received: by 2002:a05:6a20:e293:b0:39b:e1e5:a101 with SMTP id adf61e73a8af0-39ef76f86a9mr6904839637.43.1775112735196;
        Wed, 01 Apr 2026 23:52:15 -0700 (PDT)
X-Received: by 2002:a05:6a20:e293:b0:39b:e1e5:a101 with SMTP id adf61e73a8af0-39ef76f86a9mr6904789637.43.1775112734604;
        Wed, 01 Apr 2026 23:52:14 -0700 (PDT)
Received: from [10.133.33.151] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3ccc8sm2469676b3a.19.2026.04.01.23.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 23:52:13 -0700 (PDT)
Message-ID: <543e5567-2c8b-479a-8edf-a827d0637b93@oss.qualcomm.com>
Date: Thu, 2 Apr 2026 14:52:04 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] cpufreq: Pass the policy to
 cpufreq_driver->adjust_perf()
To: K Prateek Nayak <kprateek.nayak@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui <ray.huang@amd.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-rt-devel@lists.linux.dev,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>, Bert Karwatzki <spasswolf@web.de>,
        zhongqiu.han@oss.qualcomm.com
References: <20260316081849.19368-1-kprateek.nayak@amd.com>
 <20260316081849.19368-3-kprateek.nayak@amd.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260316081849.19368-3-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Q9jfIo2a c=1 sm=1 tr=0 ts=69ce1220 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=zd2uoN0lAAAA:8 a=EUspDBNiAAAA:8
 a=50MYKZWsfa7X8wndP2cA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: -oXlOCTMYoQ74WY3TH-yZl201Yq9tU8P
X-Proofpoint-ORIG-GUID: -oXlOCTMYoQ74WY3TH-yZl201Yq9tU8P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA1OSBTYWx0ZWRfXzrkSeuU3kGiw
 X+aYKMZq/IzHmyj+JaO8/8oflonsXxA9FMBoujNbCq/f0F2IqN+BuotMybDbS1wxdaWioCRlgYB
 HnhUK7mbhHUbZfxcmltMuVfLoN0zXnwQCQey+cDELQeTWC5JZEGaMUC+s3TsUlvk59KmNyc5CAr
 lWvZVXWOGbRC5Mislqkeg4jqsc6F6d9OQhJNxVs7kJdIKsKjNojxHpQ3JO7dO6ERUX4+jgLIlYI
 y7c/sZFW15TqVmg43MIK8SCNgT4dF2pBI+pgNwvPXRWjr3ci5VbwKPGi3FvN6qV93QAzNQK7AVI
 pWa7cFkx5L3ygtwXYPiE0w2SRmfLFtNqWfVax7U7GaHZgbdVMog/asVn+s70cocmUeulMPg3zS6
 zFj/MJTkFkD8OgI+FOtGeg8PHiQbD+34iKl7cp4EKsCG1+yLqoBaZAadJneYcVSDcdDCiYRGC6O
 kNwhzJqcwwKE75HHKIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020059

On 3/16/2026 4:18 PM, K Prateek Nayak wrote:
> cpufreq_cpu_get() can sleep on PREEMPT_RT in presence of concurrent
> writer(s), however amd-pstate depends on fetching the cpudata via the
> policy's driver data which necessitates grabbing the reference.
> 
> Since schedutil governor can call "cpufreq_driver->update_perf()"
> during sched_tick/enqueue/dequeue with rq_lock held and IRQs disabled,
> fetching the policy object using the cpufreq_cpu_get() helper in the
> scheduler fast-path leads to "BUG: scheduling while atomic" on
> PREEMPT_RT [1].
> 
> Pass the cached cpufreq policy object in sg_policy to the update_perf()
> instead of just the CPU. The CPU can be inferred using "policy->cpu".
> 
> The lifetime of cpufreq_policy object outlasts that of the governor and
> the cpufreq driver (allocated when the CPU is onlined and only reclaimed
> when the CPU is offlined / the CPU device is removed) which makes it
> safe to be referenced throughout the governor's lifetime.
> 
> Fixes: 1d215f0319c2 ("cpufreq: amd-pstate: Add fast switch function for AMD P-State")
> Reported-by: Bert Karwatzki <spasswolf@web.de>
> Closes:https://lore.kernel.org/all/20250731092316.3191-1-spasswolf@web.de/ [1]
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> changelog v3..v4:
> 
> o Added the Fixes tag. (Gautham, Chris Mason's review-prompts)
> ---
>   drivers/cpufreq/amd-pstate.c     |  3 +--
>   drivers/cpufreq/cpufreq.c        |  6 +++---
>   drivers/cpufreq/intel_pstate.c   |  4 ++--
>   include/linux/cpufreq.h          |  4 ++--
>   kernel/sched/cpufreq_schedutil.c |  5 +++--
>   rust/kernel/cpufreq.rs           | 13 ++++++-------
>   6 files changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5faccb3d6b14..ad4b5f84773a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -710,13 +710,12 @@ static unsigned int amd_pstate_fast_switch(struct cpufreq_policy *policy,
>   	return policy->cur;
>   }
>   
> -static void amd_pstate_adjust_perf(unsigned int cpu,
> +static void amd_pstate_adjust_perf(struct cpufreq_policy *policy,
>   				   unsigned long _min_perf,
>   				   unsigned long target_perf,
>   				   unsigned long capacity)
>   {
>   	u8 max_perf, min_perf, des_perf, cap_perf;
> -	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
>   	struct amd_cpudata *cpudata;
>   	union perf_cached perf;


Original code before the patch:

static void amd_pstate_adjust_perf(unsigned int cpu,
				   unsigned long _min_perf,
				   unsigned long target_perf,
				   unsigned long capacity)
{
	u8 max_perf, min_perf, des_perf, cap_perf;
	struct cpufreq_policy *policy __free(put_cpufreq_policy) = 
cpufreq_cpu_get(cpu);
	struct amd_cpudata *cpudata;
	union perf_cached perf;

	if (!policy)
		return;

Nit: Post-patch, the policy NULL check should no longer be necessary.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


>   
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 2082a9e4384f..17a5b8e0ea1e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2231,7 +2231,7 @@ EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
>   
>   /**
>    * cpufreq_driver_adjust_perf - Adjust CPU performance level in one go.
> - * @cpu: Target CPU.
> + * @policy: cpufreq policy object of the target CPU.
>    * @min_perf: Minimum (required) performance level (units of @capacity).
>    * @target_perf: Target (desired) performance level (units of @capacity).
>    * @capacity: Capacity of the target CPU.
> @@ -2250,12 +2250,12 @@ EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
>    * parallel with either ->target() or ->target_index() or ->fast_switch() for
>    * the same CPU.
>    */
> -void cpufreq_driver_adjust_perf(unsigned int cpu,
> +void cpufreq_driver_adjust_perf(struct cpufreq_policy *policy,
>   				 unsigned long min_perf,
>   				 unsigned long target_perf,
>   				 unsigned long capacity)
>   {
> -	cpufreq_driver->adjust_perf(cpu, min_perf, target_perf, capacity);
> +	cpufreq_driver->adjust_perf(policy, min_perf, target_perf, capacity);
>   }
>   
>   /**
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 51938c5a47ca..1552b2d32a34 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3239,12 +3239,12 @@ static unsigned int intel_cpufreq_fast_switch(struct cpufreq_policy *policy,
>   	return target_pstate * cpu->pstate.scaling;
>   }
>   
> -static void intel_cpufreq_adjust_perf(unsigned int cpunum,
> +static void intel_cpufreq_adjust_perf(struct cpufreq_policy *policy,
>   				      unsigned long min_perf,
>   				      unsigned long target_perf,
>   				      unsigned long capacity)
>   {
> -	struct cpudata *cpu = all_cpu_data[cpunum];
> +	struct cpudata *cpu = all_cpu_data[policy->cpu];
>   	u64 hwp_cap = READ_ONCE(cpu->hwp_cap_cached);
>   	int old_pstate = cpu->pstate.current_pstate;
>   	int cap_pstate, min_pstate, max_pstate, target_pstate;
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index cc894fc38971..4317c5a312bd 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -372,7 +372,7 @@ struct cpufreq_driver {
>   	 * conditions) scale invariance can be disabled, which causes the
>   	 * schedutil governor to fall back to the latter.
>   	 */
> -	void		(*adjust_perf)(unsigned int cpu,
> +	void		(*adjust_perf)(struct cpufreq_policy *policy,
>   				       unsigned long min_perf,
>   				       unsigned long target_perf,
>   				       unsigned long capacity);
> @@ -617,7 +617,7 @@ struct cpufreq_governor {
>   /* Pass a target to the cpufreq driver */
>   unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>   					unsigned int target_freq);
> -void cpufreq_driver_adjust_perf(unsigned int cpu,
> +void cpufreq_driver_adjust_perf(struct cpufreq_policy *policy,
>   				unsigned long min_perf,
>   				unsigned long target_perf,
>   				unsigned long capacity);
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 153232dd8276..ae9fd211cec1 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -461,6 +461,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
>   				     unsigned int flags)
>   {
>   	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
> +	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>   	unsigned long prev_util = sg_cpu->util;
>   	unsigned long max_cap;
>   
> @@ -482,10 +483,10 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
>   	if (sugov_hold_freq(sg_cpu) && sg_cpu->util < prev_util)
>   		sg_cpu->util = prev_util;
>   
> -	cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,
> +	cpufreq_driver_adjust_perf(sg_policy->policy, sg_cpu->bw_min,
>   				   sg_cpu->util, max_cap);
>   
> -	sg_cpu->sg_policy->last_freq_update_time = time;
> +	sg_policy->last_freq_update_time = time;
>   }
>   
>   static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index 76faa1ac8501..a83aec198336 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -1256,18 +1256,17 @@ impl<T: Driver> Registration<T> {
>       /// # Safety
>       ///
>       /// - This function may only be called from the cpufreq C infrastructure.
> +    /// - The pointer arguments must be valid pointers.
>       unsafe extern "C" fn adjust_perf_callback(
> -        cpu: c_uint,
> +        ptr: *mut bindings::cpufreq_policy,
>           min_perf: c_ulong,
>           target_perf: c_ulong,
>           capacity: c_ulong,
>       ) {
> -        // SAFETY: The C API guarantees that `cpu` refers to a valid CPU number.
> -        let cpu_id = unsafe { CpuId::from_u32_unchecked(cpu) };
> -
> -        if let Ok(mut policy) = PolicyCpu::from_cpu(cpu_id) {
> -            T::adjust_perf(&mut policy, min_perf, target_perf, capacity);
> -        }
> +        // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
> +        // lifetime of `policy`.
> +        let policy = unsafe { Policy::from_raw_mut(ptr) };
> +        T::adjust_perf(policy, min_perf, target_perf, capacity);
>       }
>   
>       /// Driver's `get_intermediate` callback.


-- 
Thx and BRs,
Zhongqiu Han
