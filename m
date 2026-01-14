Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD75832C929
	for <linux-rt-devel@lists.linux.dev>; Wed, 14 Jan 2026 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413555; cv=none; b=f/bZWBN16cxxOuBcr0fSLruiE9Z6VysIQNvMzWHsm75kfa5gWuG8NRR1fTrdBIbacX2URWgHV/r/gnpV0LC+bAqqAmgiJJYws2JgoJkaGJE+p7UrLyrUESiw5SruYm7YwyDxYIQjzGtnzmACONzQn7H0eJv4zGUVvcY9t15IusE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413555; c=relaxed/simple;
	bh=S07JpP0SHM1uUEyIuOI9Fyj0Me8tD3QHq7WHk+kqPPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iUqVO9m5ktKtBTMPI7p7fV0MVU7BUYb5tIpYT2c/1SBBIvxvkwncSa8P9FAukAlep08LKo5RliUVHoEadMRb56goFXF6OajMKMShmrc5Ne3RpaeEa3baTdKEB2rBJXRjOEIi5MyOft0/gmLc7TlSoIltFYbSqmTWDhFvKXfCugo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yh9fqL6R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zCRnoy6+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yh9fqL6R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zCRnoy6+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yh9fqL6R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zCRnoy6+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yh9fqL6R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zCRnoy6+"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC146349B0;
	Wed, 14 Jan 2026 17:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768413551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qfh28KCuJd78caeqTvGjjRVKHqXAjgHnmjbKOepb0LQ=;
	b=Yh9fqL6RvfZ4t41JSSU8Hdlhw4Lq7RUdrw2rbBZ10Y1fZFPHmr+afKsZqSkSEp+lpnrDvE
	tuvVs9QVKavsLZpmf9GMZE0iOoP8Ncz5uo3+uhoBGBVNuqouks/t+Z/HIMTaY0+ywvyDel
	hBpDCM3WJCoun/gid/A31DNPQT9DTk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768413551;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qfh28KCuJd78caeqTvGjjRVKHqXAjgHnmjbKOepb0LQ=;
	b=zCRnoy6+o+LHnj6zMJIYJWGczyGxDfAMqbdO9ebgFwVCNjw3R/P1Sq3HpOYelLZ9FhL/k5
	lLKg6SCLtR7sSOAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Yh9fqL6R;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zCRnoy6+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768413551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qfh28KCuJd78caeqTvGjjRVKHqXAjgHnmjbKOepb0LQ=;
	b=Yh9fqL6RvfZ4t41JSSU8Hdlhw4Lq7RUdrw2rbBZ10Y1fZFPHmr+afKsZqSkSEp+lpnrDvE
	tuvVs9QVKavsLZpmf9GMZE0iOoP8Ncz5uo3+uhoBGBVNuqouks/t+Z/HIMTaY0+ywvyDel
	hBpDCM3WJCoun/gid/A31DNPQT9DTk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768413551;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qfh28KCuJd78caeqTvGjjRVKHqXAjgHnmjbKOepb0LQ=;
	b=zCRnoy6+o+LHnj6zMJIYJWGczyGxDfAMqbdO9ebgFwVCNjw3R/P1Sq3HpOYelLZ9FhL/k5
	lLKg6SCLtR7sSOAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 950B53EA63;
	Wed, 14 Jan 2026 17:59:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X38PJG/ZZ2muIwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 14 Jan 2026 17:59:11 +0000
Message-ID: <0c33bdee-6de8-4d9f-92ca-4f72c1b6fb9f@suse.cz>
Date: Wed, 14 Jan 2026 18:59:11 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't acquire rt_spin_lock in
 allocate_vpe_l1_table()
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Waiman Long <llong@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>
References: <20260107215353.75612-1-longman@redhat.com>
 <864iowmrx6.wl-maz@kernel.org> <87ms2nsqju.ffs@tglx>
 <86wm1qlq7l.wl-maz@kernel.org> <87ecnwij44.ffs@tglx>
 <86v7h8l9ht.wl-maz@kernel.org>
 <40cec799-f363-4642-969b-24f5a2d56dfb@redhat.com> <87cy3eg94y.ffs@tglx>
 <5f4bfd8b-8699-4bef-bf49-f29965e95ca4@redhat.com>
 <20260113115515.98Mc29Nm@linutronix.de>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20260113115515.98Mc29Nm@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: BC146349B0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On 1/13/26 12:55, Sebastian Andrzej Siewior wrote:
> On 2026-01-12 12:14:30 [-0500], Waiman Long wrote:
>> On 1/12/26 10:09 AM, Thomas Gleixner wrote:
>> > They might be acquired though. Only alloc_pages_nolock() guarantees that
>> > no lock is taken IIRC.
>> 
>> Thanks for the suggestion. I will look into using that for page allocation.
>> I had actually attempt to use kmalloc_nolock() to replace kzalloc()
>> initially. Even though it removed the call to rmqueue(), but there were
>> other spinlocks in the slub code that were still being acquired like the
>> local_lock() or the spinlock in the get_random() code. So I gave up using

Hmm if get_random() code takes a spinlock, we have an unsolved
incompatibility with kmalloc_nolock() and CONFIG_SLAB_FREELIST_RANDOM.

>> that. Anyway, kmalloc_nolock() doesn't seem to be fully working yet.
> 
> with kmalloc_nolock() you have to be able to deal with a NULL pointer.

Yes. So even after we fix the current problems with incompatible context, I
think kmalloc_nolock() would still be a bad fit for hw bringup code that
should not really fail. Because the possibility of failure will always
exist. The BPF use case that motivated it is quite different.

> Looking at kmalloc_nolock(), it has this (in_nmi() || in_hardirq())
> check on PREEMPT_RT. The reasoning was unconditional raw_spinlock_t
> locking and bad lock-owner recording for hardirq.
> There was a trylock path for local_lock to make it work from atomic
> context. But from what I can tell this goes
>   kmalloc_nolock_noprof() -> __slab_alloc_node() -> __slab_alloc() ->
>   ___slab_alloc() -> local_lock_cpu_slab()
> 
> The last one does local_lock_irqsave() on PREEMPT_RT which does a
> spin_lock(). That means atomic context is not possible. Where did I make
> a wrong turn? Or did this change recently? I do remember that Alexei
> reworked parts of the allocator to make the local_lock based trylock
> allocation work.
> 
>> Cheers,
>> Longman
> 
> Sebastian

