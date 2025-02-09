Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA7F1D934D
	for <linux-rt-devel@lists.linux.dev>; Sun,  9 Feb 2025 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739127005; cv=none; b=dFYRqKBH0SUA3uD8wnkZF7QTakPf98NwlZykI7yNTXcaOFoJ5vq6XN0Y/kDsmA4Spd5sEJpJ0kQ6Jb2UdHtiMtGr0AzrfYLX1Z3ArJsxLp4uJaPyy5d7QcM1E5vK/QuVg1TI/Nyo8FmVjp4uWuPkMtbwBIcTs9A/PAs9xit45Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739127005; c=relaxed/simple;
	bh=3wLDvgWyN7SVzBX9JjvfScNUZMMmVLXaj6rPjdq8/8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVjXTbMQsvcsJPoIZ12XjOhr/XaTeoFQ2EXjVRJXlTfuHOJO+bhxkfwlb0YQrHsyHFkIbdK+eB9QhTD85t90O3x1EacR4Xv/FnSOETO5vKIpKXEMOcbC+Vv4Z14oxhDauxaajXDaif++Xi4Y6xrfYgdnN5AnIqTWnGIDZnp4xG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Yrc4y5BH2z9sPd;
	Sun,  9 Feb 2025 19:42:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ogLfoC-SXGTd; Sun,  9 Feb 2025 19:42:10 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Yrc4y4J49z9rvV;
	Sun,  9 Feb 2025 19:42:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7541C8B764;
	Sun,  9 Feb 2025 19:42:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id uy_LGgAXm037; Sun,  9 Feb 2025 19:42:10 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7B5028B763;
	Sun,  9 Feb 2025 19:42:09 +0100 (CET)
Message-ID: <deb0d4fa-d2ec-4acc-b217-b5ebb683bf05@csgroup.eu>
Date: Sun, 9 Feb 2025 19:42:07 +0100
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
 <93833119-9406-4d30-aa7b-4521adb3a573@csgroup.eu>
 <936f0451-a4ee-4e14-9ce9-9cd9613fc55c@linux.ibm.com>
 <0f05c020-47e4-444d-90ab-9eb8414f4ef8@csgroup.eu>
 <b95272d4-e593-48e9-aa32-8758394f4b61@linux.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <b95272d4-e593-48e9-aa32-8758394f4b61@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/02/2025 à 15:38, Shrikanth Hegde a écrit :
> 
> 
> On 2/8/25 23:25, Christophe Leroy wrote:
>>
>>
>> Le 08/02/2025 à 14:42, Shrikanth Hegde a écrit :
>>>
>>>
>>> On 2/8/25 18:25, Christophe Leroy wrote:
>>>>
>>>>
>>>> Le 08/02/2025 à 08:35, Shrikanth Hegde a écrit :
>>>>>
>>>>>
>>>>> On 2/4/25 13:52, Sebastian Andrzej Siewior wrote:
>>>>>> Use preempt_model_str() instead of manually conducting the preemption
>>>>>> model. Use pr_emerg() instead of printk() to pass a loglevel.
>>>>>
>>>>> even on powerpc, i see __die ends up calling show_regs_print_info().
>>>>> Why print it twice?
>>>>
>>>> I don't understand what you mean, what is printed twice ?
>>>>
>>>> I can't see show_regs_print_info() printing the preemption model, am 
>>>> I missing something ?
>>>>
>>>
>>> Patch 2/9 add preemption string in dump_stack_print_info.
>>>
>>> __die -> show_regs() _> show_regs_print_info() -> 
>>> dump_stack_print_info() -> init_utsname()->version, 
>>> preempt_model_str(), BUILD_ID_VAL);
>>>
>>> Wont we end up in this path?
>>
>> Indeed I missed that. You are right, we now get the information twice:
> 
> I think we can remove it from arch specific code and rely on lib/ 
> dump_stack?

Yes I guess so.

> 
> And similar concern of printk vs pr_warn/pr_emerg would apply to that as 
> well i guess.

Well, powerpc's show_regs() calls it with 
show_regs_print_info(KERN_DEFAULT);

And dump_stack_print_info() uses printk with log_lvl so there should be 
no concern here.

> 
>>
>> [  440.068216] BUG: Unable to handle kernel data access on write at 
>> 0xc09036fc

