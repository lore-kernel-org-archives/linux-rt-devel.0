Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.230
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430297;
	b=XbHladRgJWOPCTCoTIScL5N8hOWOvm/DwlKbT9IekHU/c5k+x1zP55XJqnBpu2SAihLt
	 v1pUhx6XQX2721fl9BCAI5s6pFTqWbHH0lyRaa6djHcX+JuaoXH+yZKri1TQBGHAguEg+
	 L1s86OVZXpspHuyRNPwjXpnpFnzlQzJ+vjGc12L2uz/vFcU8F12FG/k8v6OIcgtoBd+mT
	 ktfAmvBMoGVDN1/dyUSkKfPF1ki3T0hKRD2uqr1Lvy87/ieVQnamL+49ROaBOs0ne1pP5
	 HP0vfdmle1aNeM+VkAp5j4bgn0gu+RxjOqqPB/uLzzHaco03u6CyDRvNE3O6YQWGk7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430297;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=1QVI3QjKpq5IRp/fPAlVbiDEQ4TylZ7mMiLxWJOvw/Y=;
	b=LQSKZGYipB2PvKlF8Xt6Zxx98Bq/RubCulxh7hHjuT+4yJ28h0A0YdVqZ6hkTC4s1WST
	 IxNJ04ZCWyXuLzaIThj33XSDYjPx6XFN5p4y83eTXOX0gRXERdkbONVnZuXq9Mim9Zc7o
	 KHxw2MBXbeVsItQAdhapYnWxYJwb8SO77EryvLmFn/61/Z2hfLO99abq7TR2ONeDbr0Lw
	 tNsnVW7LqV0dNXB4R1U2kmY3D7U3AHQwDgxQbT3GpIdvUaeAA9zbTHal736bmHobfNGB5
	 8pQpqSOPZeIr/BDF3fNcn9SlPlsQMmY+jdCzY4bmi8AIJTlJps51tRoKGtiNQ/Hyxbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oYK0AIy4;
	arc=none smtp.remote-ip=95.215.58.230
Received: from mta1.migadu.com (out-230.mta1.migadu.com [95.215.58.230])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EB9606A319
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 17:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1EB9606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oYK0AIy4
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=q9xa9YZjnuyg7a1fSJv/UTzPcIbUjacY94dKtBXHcyA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792430294; v=1; x=1793035094;
 b=oYK0AIy4FVdhDfDyLu+EAQr2Qlefwc1wZxgktxcdwV/RuP8/peuTPUEu0kk+gN57QOyi0pEG
 LdVvOoQOeFu+Hdx63qMVqQxTXiid4cZJ+hbZJB7GE3EcV1OO0i3qo9qiODKlUHESbm8UDlw82Wj
 9xjkGiFLUr21mDG7rZ+d3SdM=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 2f87e9bf7523bc8a;
	Mon, 19 Oct 2026 17:18:14 +0000
X-Mizu-Trace-ID: 2f87e9bf7523bc8a
X-Migadu-Flow: FLOW_OUT
Message-ID: <b957b12e-f272-4dbf-a308-c6b61bcb3d66@linux.dev>
Date: Tue, 20 Oct 2026 01:18:06 +0800
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6-rt 0/5] net: Backport backlog-NAPI threads to resolve
 PREEMPT_RT softirq warning in SMP flush
To: Clark Williams <clrkwllms@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev
References: <cover.1792345413.git.wen.yang@linux.dev>
 <atYZLK0gmG8vRHxG@demetrius>
Content-Language: en-US
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <atYZLK0gmG8vRHxG@demetrius>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/19/26 21:20, Clark Williams wrote:
> On Mon, Oct 19, 2026 at 02:15:22AM +0800, wen.yang@linux.dev wrote:
>> From: Wen Yang <wen.yang@linux.dev>
>>
>> Backport backlog-NAPI threads to v6.6-rt-next first, as requested by
>> Sebastian and Clark, before following up with the v6.1-rt backport.
>> The base is 4c4970859022 (Linux 6.6.151-rt78-rc1).
>>
>> The existing RT workaround, 1f7514c9c75d ("net: Avoid the IPI to free the"),
>> redirects deferred skb cleanup to a worker but leaves RPS remote-backlog
>> scheduling on the function-call IPI path. In a fresh RT guest this still
>> triggers do_softirq_post_smp_call_flush() from idle queue flushing.
>>
>> The ten earlier NAPI/RPS prerequisites are already present in v6.6, so this
>> series reverts the workaround and backports the four upstream changes (all
>> in upstream v6.10) in dependency order. Backlog-NAPI threads replace the
>> RPS/defer function-call notifications; ordinary scheduler wakeup IPI traffic
>> can still occur. Two of the changes were previously backported to ordinary
>> 6.6.y and reverted (507692c05636, 5a530c8ead06) only because PREEMPT_RT is
>> absent there, not for a functional defect.
>>
>> Backport notes
>> --------------
>> Only 3/5 needs context adaptations; they are listed in that patch's commit
>> message. The other four apply without context edits. Unlike v6.1, v6.6 keeps
>> WRITE_ONCE(napi->list_owner, ...) because the field already exists here.
>>
>> Verification
>> ------------
>> Each of the five stages was replayed against the base snapshot and compiled
>> for net/core/dev.o and net/core/skbuff.o. The baseline and final RT/RPS
>> bzImages were built with byte-identical normalized configs using GCC 9.4.0,
>> with no compiler warnings or errors.
>>
>> Tests use virtme-ng 1.38, x86_64 QEMU/KVM, four vCPUs and 2 GiB memory:
>>
>>    vng --run <bzImage> --cpus 4 --memory 2G \
>>        --qemu-opts='-machine accel=kvm' --exec 'bash <script>'
>>
>> The config enables PREEMPT_RT, SMP, SYSFS, NET_NS, VETH, RPS,
>> IRQ_TIME_ACCOUNTING and KPROBES, with NR_CPUS=4. Run the inline script below
>> in a fresh guest for each image; it prints one column of the table, and the
>> columns are joined outside the guest. It covers both mechanisms: the RPS/IPI
>> path (ping flood with RPS steered to CPU1) and the defer_list purge path
>> (cross-CPU TCP frees traced with kprobes). See its header for details.
>>
> 
> Wen,
> 
> I just pushed v6.6.159-rt82-rc1 up to the linux-stable-rt repository in
> v6.6-rt-next, waiting for kernelci.org to pick it up and test it. I'll
> let it soak for a bit so people can test it, then we can release it
> later this week.
> 
> I'm betting the v6.1-rt series is going to be a bit bigger?  :)
> 

Hi,

Thanks for pushing the rc, and for giving it time to soak before release.
On your question about the v6.1 series - you're right, it is larger:
15 patches. That is mostly because 6.1.y does not carry the ten 
NAPI/RPS/ defer_list prerequisites from v6.4-v6.9 that v6.6 already has, 
so they have to come along:
     10  prerequisite NAPI/RPS/defer_list patches
      4  the backlog-NAPI changes (the same set as the v6.6 series)
      1  revert of the RT defer_work workaround

Only one of the 14 upstream patches needed a change beyond context: 
patch 06 keeps raise_softirq_irqoff() instead of 
__raise_softirq_irqoff(), since 6.1-rt already carries 533824e6a0fb and 
the 2023 upstream text predates it.
The other 13 are line-for-line identical, and patch 13's five 
hand-placed hunks are context only.

The code is unchanged since I posted it, so there is nothing new to 
send; please feel free to apply and test the series as posted.

https://lore.kernel.org/all/cover.1791912669.git.wen.yang@linux.dev/


Thanks,
Wen








