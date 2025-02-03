Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F882063CC
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Feb 2025 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738601405; cv=none; b=X2QRvk8mZfI9balUaogFZg7fzr4SRTn2W02Ud+6101X+UNxlcrCP6WKirm5CPsMJSj9oOB8VCVX1OJpGb1vtBfqG3/glFYKIwqQQlb6JGZGlqSxwXn6UfvzosAcxlxvUmBk/4zgdxeKifkEqk5MO2SymuHoaKKEVBZOl6Re8bN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738601405; c=relaxed/simple;
	bh=qMEOn1ZLJjRhleSdtyp3CLsHEpZHR6URjPHHBWcRiFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R0GbbTdy0DMyOACAcmfiLoSiYL7KVa5LtMnxtmyhksFlF+DnRPNv4woS4UqsyRco4DTjjP86Dw9jjQExm/MlmLp/ezOYaKa99MsK5XSKPjfE8Da9k1xURM4D9FnIp45HeKftUGMSHYm9hmsQczpQxoZKRbEtd6p4Wm1yVRADsN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Ymsc858W3z9sSp;
	Mon,  3 Feb 2025 17:37:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zL6lv9C8apOs; Mon,  3 Feb 2025 17:37:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Ymsc84GNtz9sSn;
	Mon,  3 Feb 2025 17:37:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7EB188B764;
	Mon,  3 Feb 2025 17:37:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Qc-OfRrFF4mj; Mon,  3 Feb 2025 17:37:44 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 519808B763;
	Mon,  3 Feb 2025 17:37:43 +0100 (CET)
Message-ID: <51999b8e-61c0-48b7-b744-c83d39e7f311@csgroup.eu>
Date: Mon, 3 Feb 2025 17:37:42 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] powerpc: Use preempt_model_str().
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
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250203160103.9DikC9FJ@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/02/2025 à 17:01, Sebastian Andrzej Siewior a écrit :
> On 2025-02-03 16:19:06 [+0100], Christophe Leroy wrote:
>>
>>
>> Le 03/02/2025 à 15:16, Sebastian Andrzej Siewior a écrit :
>>> Use preempt_model_str() instead of manually conducting the preemption
>>> model. Use pr_emerg() instead of printk() to pass a loglevel.
>>
>> Why use pr_emerg() for that line and not all other ones ?
> 
> checkpatch complained for the current printk() line and this looks like
> an emergency coming from die().

Right but checkpatch only looks at the line you modify with your patch, 
it doesn't consider the global picture.

> 
>> The purpose of using printk() is to get it at the level defined by
>> CONFIG_MESSAGE_LOGLEVEL_DEFAULT and I think it is important to have the full
>> Oops block at the same level.
> 
> Okay. So "printk(KERN_DEFAULT " then.

Up to you, I'm fine with that but you should consistently update all 
printk's in the function, not only that one, so is it really worth it ?

Christophe

