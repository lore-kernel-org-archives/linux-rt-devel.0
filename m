Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5143621D5AE
	for <linux-rt-devel@lists.linux.dev>; Wed,  5 Feb 2025 07:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738740009; cv=none; b=fPo2npiIPoZPzBNsZx1ffw8Uc4WRPrtjbBthzADM3qna+ICqSP6mT0xI+g9LUycy/VJS866kfV0Jz8pqYK1jCjn4S0AOK4iiatD/vfaH7w8YLAca3qibTEk+qsK8P28HrRoEPebYQZphgyFQkk5WlOuLjQ+lf2VF1/fupa7wr8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738740009; c=relaxed/simple;
	bh=g6uOaiTz5SxuO0+8uDAIShIuR84JiEmgHPF6qzalGtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RS8bInLrXg7AikbQDAEn+gpnfrnoLlpzOPlfh0OXE7ikNR12LnqQwAxtP2jyUNc2Kc6/GSSuVAu2W3CfXmDmyzwwbCUalzCpr2h7LX/sSfvSrru3xlV26Z9NQzA9xT3HTPXMsXPlXqd9rXbt7JJHyMC4rdZDXsPK8ZJpmOKsGIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YnrRj3MVVz9sS7;
	Wed,  5 Feb 2025 07:48:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id puRhBqOAeMVL; Wed,  5 Feb 2025 07:48:49 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YnrQz089Jz9sPd;
	Wed,  5 Feb 2025 07:48:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E763E8B765;
	Wed,  5 Feb 2025 07:48:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Pe9u4pJlBqwz; Wed,  5 Feb 2025 07:48:10 +0100 (CET)
Received: from [10.25.207.138] (unknown [10.25.207.138])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5EDA48B763;
	Wed,  5 Feb 2025 07:48:10 +0100 (CET)
Message-ID: <cc9f0470-830b-471a-ac8d-33ba2e89dc8c@csgroup.eu>
Date: Wed, 5 Feb 2025 07:48:09 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] powerpc: Use preempt_model_str().
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Ben Segall <bsegall@google.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Peter Zijlstra <peterz@infradead.org>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Will Deacon <will@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, linuxppc-dev@lists.ozlabs.org
References: <20250203141632.440554-1-bigeasy@linutronix.de>
 <20250203141632.440554-6-bigeasy@linutronix.de>
 <65c6f60d-bb52-48bd-a02c-87ffd2a915d4@csgroup.eu>
 <20250203160103.9DikC9FJ@linutronix.de>
 <51999b8e-61c0-48b7-b744-c83d39e7f311@csgroup.eu>
 <20250204082223.6iNyq_KR@linutronix.de>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250204082223.6iNyq_KR@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/02/2025 à 09:22, Sebastian Andrzej Siewior a écrit :
> Use preempt_model_str() instead of manually conducting the preemption
> model. Use pr_emerg() instead of printk() to pass a loglevel.
> 
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Naveen N Rao <naveen@kernel.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
> v2…v3:
>    - Use printk() instead of pr_emerg() to remain consistent with the
>      other invocations in terms of printing context.
> 
>   arch/powerpc/kernel/traps.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index edf5cabe5dfdb..d6d77d92b3358 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -263,10 +263,10 @@ static int __die(const char *str, struct pt_regs *regs, long err)
>   {
>   	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
>   
> -	printk("%s PAGE_SIZE=%luK%s%s%s%s%s%s %s\n",
> +	printk("%s PAGE_SIZE=%luK%s %s %s%s%s%s %s\n",
>   	       IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? "LE" : "BE",
>   	       PAGE_SIZE / 1024, get_mmu_str(),
> -	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "",
> +	       preempt_model_str(),
>   	       IS_ENABLED(CONFIG_SMP) ? " SMP" : "",
>   	       IS_ENABLED(CONFIG_SMP) ? (" NR_CPUS=" __stringify(NR_CPUS)) : "",
>   	       debug_pagealloc_enabled() ? " DEBUG_PAGEALLOC" : "",

