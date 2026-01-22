Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE263994B5
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100496; cv=none; b=JBm2TkmTjZeJGh+m+zdhL2ioSebC3PC8rl20t/dL9512ZIzTF47OxpE8G7tGzHYnzgAu7lyylEcBo6DaC/5uta6nXBo5jRbbYu/ZsEcA2qwJhOHvb8bbX/NkswVLuO2RJxlMF0kVh/eJoBa2l7pIA1oRz9eGITIw6b1PwLRd9ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100496; c=relaxed/simple;
	bh=CZneDtKjx1DfJCIzadT+9rl9cVHzO16jJzSw2YwXb7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRwPJMbPlP1HffxeQ35QGp2n4j+2ZX2NCeZRs2DD0/W2nBS5qQx63zptcvXXOWnDVTiui9KiGvAlVupcrktAsokSG5R5108BjM7RVBzVdMKdVsjVRVk2e4h3BnqZzaOwJR3w2BE2gCtCFI5upMX+bOfXJZJjOQDEPPDhzd6r/pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MjZp15/J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PWSoiWUC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MjZp15/J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PWSoiWUC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MjZp15/J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PWSoiWUC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MjZp15/J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PWSoiWUC"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3B5025BCCF;
	Thu, 22 Jan 2026 16:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769100488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DTKUT95vtZNaUuYNiG1RUcc6EeE9vgfhUNuCA2Z91W0=;
	b=MjZp15/JH//Pl53I15y7OMbRTd+4gN8GEOaUQZW3tg0xHc3VkX+vN8f676BbZXD48vwUtO
	VDv56vtDF0w5wLDv03YUox9fkgzI3KV5a8AtLapNUyLIGKaoXPQPAB/qEubZ1JV6cmIBdv
	RuGV7lipci2qn1J/ZkFjUNAMPJl6RBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769100488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DTKUT95vtZNaUuYNiG1RUcc6EeE9vgfhUNuCA2Z91W0=;
	b=PWSoiWUCM+eDk4Lyu/khgEeFs/c6001adWpNplcuRzh0PAKf87Lh7gIpKo9JIVxYFltQML
	Cb+WPae5a8EAWvCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="MjZp15/J";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PWSoiWUC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769100488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DTKUT95vtZNaUuYNiG1RUcc6EeE9vgfhUNuCA2Z91W0=;
	b=MjZp15/JH//Pl53I15y7OMbRTd+4gN8GEOaUQZW3tg0xHc3VkX+vN8f676BbZXD48vwUtO
	VDv56vtDF0w5wLDv03YUox9fkgzI3KV5a8AtLapNUyLIGKaoXPQPAB/qEubZ1JV6cmIBdv
	RuGV7lipci2qn1J/ZkFjUNAMPJl6RBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769100488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DTKUT95vtZNaUuYNiG1RUcc6EeE9vgfhUNuCA2Z91W0=;
	b=PWSoiWUCM+eDk4Lyu/khgEeFs/c6001adWpNplcuRzh0PAKf87Lh7gIpKo9JIVxYFltQML
	Cb+WPae5a8EAWvCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E0691395E;
	Thu, 22 Jan 2026 16:48:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wWGVAchUcmm2LwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 22 Jan 2026 16:48:08 +0000
Message-ID: <7876e97c-9afb-418a-8ef7-5f4f306b7eea@suse.cz>
Date: Thu, 22 Jan 2026 17:48:07 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 02/10] mm/vma: document possible vma->vm_refcnt
 values and reference comment
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Jann Horn <jannh@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com>
 <a28f56dbe5057385b07498684dfb105918bf3644.1769086312.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJnyBr8BQka0IFQAAoJECJPp+fMgqZkqmMQ
 AIbGN95ptUMUvo6aAdhxaOCHXp1DfIBuIOK/zpx8ylY4pOwu3GRe4dQ8u4XS9gaZ96Gj4bC+
 jwWcSmn+TjtKW3rH1dRKopvC07tSJIGGVyw7ieV/5cbFffA8NL0ILowzVg8w1ipnz1VTkWDr
 2zcfslxJsJ6vhXw5/npcY0ldeC1E8f6UUoa4eyoskd70vO0wOAoGd02ZkJoox3F5ODM0kjHu
 Y97VLOa3GG66lh+ZEelVZEujHfKceCw9G3PMvEzyLFbXvSOigZQMdKzQ8D/OChwqig8wFBmV
 QCPS4yDdmZP3oeDHRjJ9jvMUKoYODiNKsl2F+xXwyRM2qoKRqFlhCn4usVd1+wmv9iLV8nPs
 2Db1ZIa49fJet3Sk3PN4bV1rAPuWvtbuTBN39Q/6MgkLTYHb84HyFKw14Rqe5YorrBLbF3rl
 M51Dpf6Egu1yTJDHCTEwePWug4XI11FT8lK0LNnHNpbhTCYRjX73iWOnFraJNcURld1jL1nV
 r/LRD+/e2gNtSTPK0Qkon6HcOBZnxRoqtazTU6YQRmGlT0v+rukj/cn5sToYibWLn+RoV1CE
 Qj6tApOiHBkpEsCzHGu+iDQ1WT0Idtdynst738f/uCeCMkdRu4WMZjteQaqvARFwCy3P/jpK
 uvzMtves5HvZw33ZwOtMCgbpce00DaET4y/UzsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZ8gcVAUJFhTonwAKCRAiT6fnzIKmZLY8D/9uo3Ut9yi2YCuASWxr7QQZ
 lJCViArjymbxYB5NdOeC50/0gnhK4pgdHlE2MdwF6o34x7TPFGpjNFvycZqccSQPJ/gibwNA
 zx3q9vJT4Vw+YbiyS53iSBLXMweeVV1Jd9IjAoL+EqB0cbxoFXvnjkvP1foiiF5r73jCd4PR
 rD+GoX5BZ7AZmFYmuJYBm28STM2NA6LhT0X+2su16f/HtummENKcMwom0hNu3MBNPUOrujtW
 khQrWcJNAAsy4yMoJ2Lw51T/5X5Hc7jQ9da9fyqu+phqlVtn70qpPvgWy4HRhr25fCAEXZDp
 xG4RNmTm+pqorHOqhBkI7wA7P/nyPo7ZEc3L+ZkQ37u0nlOyrjbNUniPGxPxv1imVq8IyycG
 AN5FaFxtiELK22gvudghLJaDiRBhn8/AhXc642/Z/yIpizE2xG4KU4AXzb6C+o7LX/WmmsWP
 Ly6jamSg6tvrdo4/e87lUedEqCtrp2o1xpn5zongf6cQkaLZKQcBQnPmgHO5OG8+50u88D9I
 rywqgzTUhHFKKF6/9L/lYtrNcHU8Z6Y4Ju/MLUiNYkmtrGIMnkjKCiRqlRrZE/v5YFHbayRD
 dJKXobXTtCBYpLJM4ZYRpGZXne/FAtWNe4KbNJJqxMvrTOrnIatPj8NhBVI0RSJRsbilh6TE
 m6M14QORSWTLRg==
In-Reply-To: <a28f56dbe5057385b07498684dfb105918bf3644.1769086312.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.01
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,google.com,suse.com,linux.dev,kvack.org,vger.kernel.org,lists.linux.dev,infradead.org,redhat.com,gmail.com,linutronix.de,goodmis.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3B5025BCCF
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On 1/22/26 14:01, Lorenzo Stoakes wrote:
> The possible vma->vm_refcnt values are confusing and vague, explain in
> detail what these can be in a comment describing the vma->vm_refcnt field
> and reference this comment in various places that read/write this field.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks, very useful. Forgive my nitpicks :) It's because it's tricky so best
try to be as precise as possible, I believe.

> ---
>  include/linux/mm_types.h  | 39 +++++++++++++++++++++++++++++++++++++--
>  include/linux/mmap_lock.h |  7 +++++++
>  mm/mmap_lock.c            |  6 ++++++
>  3 files changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 94de392ed3c5..e5ee66f84d9a 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -758,7 +758,8 @@ static inline struct anon_vma_name *anon_vma_name_alloc(const char *name)
>   * set the VM_REFCNT_EXCLUDE_READERS_FLAG in vma->vm_refcnt to indiciate to
>   * vma_start_read() that the reference count should be left alone.
>   *
> - * Once the operation is complete, this value is subtracted from vma->vm_refcnt.
> + * See the comment describing vm_refcnt in vm_area_struct for details as to
> + * which values the VMA reference count can be.
>   */
>  #define VM_REFCNT_EXCLUDE_READERS_BIT	(30)
>  #define VM_REFCNT_EXCLUDE_READERS_FLAG	(1U << VM_REFCNT_EXCLUDE_READERS_BIT)
> @@ -989,7 +990,41 @@ struct vm_area_struct {
>  	struct vma_numab_state *numab_state;	/* NUMA Balancing state */
>  #endif
>  #ifdef CONFIG_PER_VMA_LOCK
> -	/* Unstable RCU readers are allowed to read this. */
> +	/*
> +	 * Used to keep track of the number of references taken by VMA read or
> +	 * write locks. May have the VM_REFCNT_EXCLUDE_READERS_FLAG set

I wonder about the "or write locks" part. The process of acquiring it uses
VM_REFCNT_EXCLUDE_READERS_FLAG but then the writer doesn't hold a 1
refcount? (the sentence could be read it way IMHO) It's vma being attached
that does, AFAIK?

> +	 * indicating that a thread has entered __vma_enter_locked() and is
> +	 * waiting on any outstanding read locks to exit.
> +	 *
> +	 * This value can be equal to:
> +	 *
> +	 * 0 - Detached.

Is it worth saying that readers can't increment the refcount?

> +	 * 1 - Unlocked or write-locked.

"Attached and either unlocked or write-locked." ?

(see how "write-locked" isn't reflected, I argued above)

> +	 *
> +	 * >1, < VM_REFCNT_EXCLUDE_READERS_FLAG - Read-locked or (unlikely)
> +	 * write-locked with other threads having temporarily incremented the
> +	 * reference count prior to determining it is write-locked and
> +	 * decrementing it again.

Ack.

> +	 * VM_REFCNT_EXCLUDE_READERS_FLAG - Detached, pending
> +	 * __vma_exit_locked() completion which will decrement the reference
> +	 * count to zero. IMPORTANT - at this stage no further readers can
> +	 * increment the reference count. It can only be reduced.
> +	 *
> +	 * VM_REFCNT_EXCLUDE_READERS_FLAG + 1 - Either an attached VMA pending
> +	 * __vma_exit_locked() completion which will decrement the reference
> +	 * count to one, OR a detached VMA waiting on a single spurious reader
> +	 * to decrement reference count. IMPORTANT - as above, no further
> +	 * readers can increment the reference count.
> +	 *
> +	 * > VM_REFCNT_EXCLUDE_READERS_FLAG + 1 - VMA is waiting on readers,

"VMA is waiting" sounds weird? a thread might be, but VMA itself?
(similarly in the previous paragraph)

> +	 * whether it is attempting to acquire a write lock or attempting to
> +	 * detach. IMPORTANT - as above, no ruther readers can increment the
> +	 * reference count.
> +	 *
> +	 * NOTE: Unstable RCU readers are allowed to read this.
> +	 */
>  	refcount_t vm_refcnt ____cacheline_aligned_in_smp;
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  	struct lockdep_map vmlock_dep_map;
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 5acbd4ba1b52..a764439d0276 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -130,6 +130,9 @@ static inline bool is_vma_writer_only(int refcnt)
>  	 * attached. Waiting on a detached vma happens only in
>  	 * vma_mark_detached() and is a rare case, therefore most of the time
>  	 * there will be no unnecessary wakeup.
> +	 *
> +	 * See the comment describing the vm_area_struct->vm_refcnt field for
> +	 * details of possible refcnt values.
>  	 */
>  	return (refcnt & VM_REFCNT_EXCLUDE_READERS_FLAG) &&
>  		refcnt <= VM_REFCNT_EXCLUDE_READERS_FLAG + 1;
> @@ -249,6 +252,10 @@ static inline void vma_assert_locked(struct vm_area_struct *vma)
>  {
>  	unsigned int mm_lock_seq;
> 
> +	/*
> +	 * See the comment describing the vm_area_struct->vm_refcnt field for
> +	 * details of possible refcnt values.
> +	 */
>  	VM_BUG_ON_VMA(refcount_read(&vma->vm_refcnt) <= 1 &&
>  		      !__is_vma_write_locked(vma, &mm_lock_seq), vma);
>  }
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 1d23b48552e9..75dc098aea14 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -65,6 +65,9 @@ static inline int __vma_enter_locked(struct vm_area_struct *vma,
>  	/*
>  	 * If vma is detached then only vma_mark_attached() can raise the
>  	 * vm_refcnt. mmap_write_lock prevents racing with vma_mark_attached().
> +	 *
> +	 * See the comment describing the vm_area_struct->vm_refcnt field for
> +	 * details of possible refcnt values.
>  	 */
>  	if (!refcount_add_not_zero(VM_REFCNT_EXCLUDE_READERS_FLAG, &vma->vm_refcnt))
>  		return 0;
> @@ -137,6 +140,9 @@ void vma_mark_detached(struct vm_area_struct *vma)
>  	 * before they check vm_lock_seq, realize the vma is locked and drop
>  	 * back the vm_refcnt. That is a narrow window for observing a raised
>  	 * vm_refcnt.
> +	 *
> +	 * See the comment describing the vm_area_struct->vm_refcnt field for
> +	 * details of possible refcnt values.
>  	 */
>  	if (unlikely(!refcount_dec_and_test(&vma->vm_refcnt))) {
>  		/* Wait until vma is detached with no readers. */
> --
> 2.52.0

