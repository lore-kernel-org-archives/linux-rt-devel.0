Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BC11ADFEB
	for <linux-rt-devel@lists.linux.dev>; Sat,  8 Feb 2025 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739020807; cv=none; b=lZNp14O0TAYny+ZFIHo1q/Sn1WeLuImM5jGxL6YjWtUL6xbuqWDqmMxdGYtzdDlzuENsuQpAZxXi6X+Hx18ZwXPyzFhCSUpueaoxfsySTsRFxOCF2W8T6Pw8pOj5AVgATniVifDEvk7GN7wOqT4LlxtiDN78si/iFlxWd0cTKS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739020807; c=relaxed/simple;
	bh=DexpIvr88TdfO7k5m5iLsPlnbkVUejXzYo7r7+Qsk4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxUTnNb6TVLyYvT3985qIWBD8iX31pb1inbMBEZj8n51K3MBK5stUJQEECER6pWGaIARvi7YmmPdHTu/GYdb3TT3HmgdIhJTJmTYyXa803SIK0Nx12Y8LKuGSy370+arfVh1MJJFQjCn5cmET/c4wqyQhR7DUIqkunOgzq5ap40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YqrRV4Svsz9sPd;
	Sat,  8 Feb 2025 13:55:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B33kh4nvbrt9; Sat,  8 Feb 2025 13:55:34 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YqrRV3TKqz9rvV;
	Sat,  8 Feb 2025 13:55:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6E51C8B79C;
	Sat,  8 Feb 2025 13:55:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id pakRPOock7vB; Sat,  8 Feb 2025 13:55:34 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8030B8B763;
	Sat,  8 Feb 2025 13:55:33 +0100 (CET)
Message-ID: <93833119-9406-4d30-aa7b-4521adb3a573@csgroup.eu>
Date: Sat, 8 Feb 2025 13:55:31 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] powerpc: Use preempt_model_str().
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Ben Segall <bsegall@google.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>,
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
 <7b51f7de-8e4b-4766-85ca-dee24832c693@linux.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <7b51f7de-8e4b-4766-85ca-dee24832c693@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/02/2025 à 08:35, Shrikanth Hegde a écrit :
> 
> 
> On 2/4/25 13:52, Sebastian Andrzej Siewior wrote:
>> Use preempt_model_str() instead of manually conducting the preemption
>> model. Use pr_emerg() instead of printk() to pass a loglevel.
> 
> even on powerpc, i see __die ends up calling show_regs_print_info().
> Why print it twice?

I don't understand what you mean, what is printed twice ?

I can't see show_regs_print_info() printing the preemption model, am I 
missing something ?

Christophe

> 
>>
>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Cc: Naveen N Rao <naveen@kernel.org>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> ---
>> v2…v3:
>>    - Use printk() instead of pr_emerg() to remain consistent with the
>>      other invocations in terms of printing context.
>>
>>   arch/powerpc/kernel/traps.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
>> index edf5cabe5dfdb..d6d77d92b3358 100644
>> --- a/arch/powerpc/kernel/traps.c
>> +++ b/arch/powerpc/kernel/traps.c
>> @@ -263,10 +263,10 @@ static int __die(const char *str, struct pt_regs 
>> *regs, long err)
>>   {
>>       printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
>> -    printk("%s PAGE_SIZE=%luK%s%s%s%s%s%s %s\n",
>> +    printk("%s PAGE_SIZE=%luK%s %s %s%s%s%s %s\n",
>>              IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? "LE" : "BE",
>>              PAGE_SIZE / 1024, get_mmu_str(),
>> -           IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "",
>> +           preempt_model_str(),
>>              IS_ENABLED(CONFIG_SMP) ? " SMP" : "",
>>              IS_ENABLED(CONFIG_SMP) ? (" NR_CPUS=" 
>> __stringify(NR_CPUS)) : "",
>>              debug_pagealloc_enabled() ? " DEBUG_PAGEALLOC" : "",
> 

