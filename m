Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2155F2C0F7C
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159786; cv=none; b=tU2qBoIGGaZOYS/T5jslxEdIBQZNkiaQAPkfZpQCvC3015FI902kaCnBxfhv56Mrsht/Y69m6TTN4pwKoBjWIqNXie4Q/h//o6wLBufthKDG3hAXpzH9T3mShG1Px7r1adls+KWXsvdhvZnvuuaTJgWpsIIl0dfVVXCaJi9cA8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159786; c=relaxed/simple;
	bh=i8NhGQIL8YbQaoZCFde4IZ8iFDxMG25wgv7usEunT9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfQTbaTLqWs9QsnU6pNI3htTTEvKyZW12Ch9D6VGKLEfgWn3ZQ73vMe+j7mvHVn0SK4g4LQzcNSwd0KXILpK1ShLr/NGXS4WqUhGrLcrhV8VXMajdIbLe/px6qFfxDhsjv7buV65sTGHP5VqYr4fp45+G7ImjagI+A0iGqGG2SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E9+Up9yt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iJqVr637; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E9+Up9yt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iJqVr637; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E9+Up9yt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iJqVr637";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E9+Up9yt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iJqVr637"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 383F7337A2;
	Fri, 23 Jan 2026 09:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769159783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QaHFUJmm4rgOsPZW7XwxvKLrYqLatT2YXmaLB5JZs9Q=;
	b=E9+Up9ytafDjly4JhtU1TWUHbNTXOqMvvyuPpBWtR+ilQgXY3Ut4xR9rY6UE5Gxx9S0Zoc
	Wd5aJ3ajAIRTiwdTIMCr2P8HQfJt7kchEmkJD1IhWVbuafIGqaaASugcLLs+NR30O5d7/b
	F8iQuyDY8G/8zuRLlmCnGMueDNn7okg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769159783;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QaHFUJmm4rgOsPZW7XwxvKLrYqLatT2YXmaLB5JZs9Q=;
	b=iJqVr63702reQuh6aIoeHRPbYfufdjmDRMytiysYrRdxkwxQBm6NoM8qk6Qm3Ah+/Etmj+
	475NR6psKnEyfQBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=E9+Up9yt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iJqVr637
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769159783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QaHFUJmm4rgOsPZW7XwxvKLrYqLatT2YXmaLB5JZs9Q=;
	b=E9+Up9ytafDjly4JhtU1TWUHbNTXOqMvvyuPpBWtR+ilQgXY3Ut4xR9rY6UE5Gxx9S0Zoc
	Wd5aJ3ajAIRTiwdTIMCr2P8HQfJt7kchEmkJD1IhWVbuafIGqaaASugcLLs+NR30O5d7/b
	F8iQuyDY8G/8zuRLlmCnGMueDNn7okg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769159783;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QaHFUJmm4rgOsPZW7XwxvKLrYqLatT2YXmaLB5JZs9Q=;
	b=iJqVr63702reQuh6aIoeHRPbYfufdjmDRMytiysYrRdxkwxQBm6NoM8qk6Qm3Ah+/Etmj+
	475NR6psKnEyfQBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08B521395E;
	Fri, 23 Jan 2026 09:16:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XRjRAWc8c2lhbAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 23 Jan 2026 09:16:23 +0000
Message-ID: <0567268d-edea-4229-8bf4-bfbfc2af1fd4@suse.cz>
Date: Fri, 23 Jan 2026 10:16:22 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/10] mm/vma: clean up __vma_enter/exit_locked()
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
 <f1981963e3c9421b6ffef19f15d87953895cd0b5.1769086312.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <f1981963e3c9421b6ffef19f15d87953895cd0b5.1769086312.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.01
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,google.com,suse.com,linux.dev,kvack.org,vger.kernel.org,lists.linux.dev,infradead.org,redhat.com,gmail.com,linutronix.de,goodmis.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 383F7337A2
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On 1/22/26 14:01, Lorenzo Stoakes wrote:
> These functions are very confusing indeed. 'Entering' a lock could be
> interpreted as acquiring it, but this is not what these functions are
> interacting with.
> 
> Equally they don't indicate at all what kind of lock we are 'entering' or
> 'exiting'. Finally they are misleading as we invoke these functions when we
> already hold a write lock to detach a VMA.
> 
> These functions are explicitly simply 'entering' and 'exiting' a state in
> which we hold the EXCLUSIVE lock in order that we can either mark the VMA
> as being write-locked, or mark the VMA detached.

If we hold a write lock (i.e. in vma_mark_detached()), that normally means
it's also exclusive?
And if we talk about the state between __vma_enter_exclusive_locked and
__vma_exit_exclusive_locked() as "holding an EXCLUSIVE lock", it's not
exactly the same lock as what we call "VMA write lock" right, so what lock
is it?

Maybe it would help if we stopped calling this internal thing a "lock"?
Except we use it for lockdep's lock_acquire_exclusive(). Sigh, sorry I don't
have any great suggestion.

Maybe call those functions __vma_exclude_readers_start() and
__vma_exclude_readers_end() instead, or something?

> Rename the functions accordingly, and also update
> __vma_exit_exclusive_locked() to return detached state with a __must_check
> directive, as it is simply clumsy to pass an output pointer here to
> detached state and inconsistent vs. __vma_enter_exclusive_locked().
> 
> Finally, remove the unnecessary 'inline' directives.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/mmap_lock.h |  4 +--
>  mm/mmap_lock.c            | 60 +++++++++++++++++++++++++--------------
>  2 files changed, 41 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index da63b1be6ec0..873bc5f3c97c 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -209,8 +209,8 @@ static inline void vma_refcount_put(struct vm_area_struct *vma)
>  	__vma_lockdep_release_read(vma);
>  	detached = __vma_refcount_put(vma, &refcnt);
>  	/*
> -	 * __vma_enter_locked() may be sleeping waiting for readers to drop
> -	 * their reference count, so wake it up if we were the last reader
> +	 * __vma_enter_exclusive_locked() may be sleeping waiting for readers to
> +	 * drop their reference count, so wake it up if we were the last reader
>  	 * blocking it from being acquired.
>  	 */
>  	if (!detached && are_readers_excluded(refcnt))
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 7a0361cff6db..f73221174a8b 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -46,19 +46,43 @@ EXPORT_SYMBOL(__mmap_lock_do_trace_released);
>  #ifdef CONFIG_MMU
>  #ifdef CONFIG_PER_VMA_LOCK
>  
> -static inline void __vma_exit_locked(struct vm_area_struct *vma, bool *detached)
> +/*
> + * Now that all readers have been evicted, mark the VMA as being out of the
> + * 'exclude readers' state.
> + *
> + * Returns true if the VMA is now detached, otherwise false.
> + */
> +static bool __must_check __vma_exit_exclusive_locked(struct vm_area_struct *vma)
>  {
> -	*detached = refcount_sub_and_test(VM_REFCNT_EXCLUDE_READERS_FLAG,
> -					  &vma->vm_refcnt);
> +	bool detached;
> +
> +	detached = refcount_sub_and_test(VM_REFCNT_EXCLUDE_READERS_FLAG,
> +					 &vma->vm_refcnt);
>  	__vma_lockdep_release_exclusive(vma);
> +	return detached;
>  }
>  
>  /*
> - * __vma_enter_locked() returns 0 immediately if the vma is not
> - * attached, otherwise it waits for any current readers to finish and
> - * returns 1.  Returns -EINTR if a signal is received while waiting.
> + * Mark the VMA as being in a state of excluding readers, check to see if any
> + * VMA read locks are indeed held, and if so wait for them to be released.
> + *
> + * Note that this function pairs with vma_refcount_put() which will wake up this
> + * thread when it detects that the last reader has released its lock.
> + *
> + * The state parameter ought to be set to TASK_UNINTERRUPTIBLE in cases where we
> + * wish the thread to sleep uninterruptibly or TASK_KILLABLE if a fatal signal
> + * is permitted to kill it.
> + *
> + * The function will return 0 immediately if the VMA is detached, and 1 once the
> + * VMA has evicted all readers, leaving the VMA exclusively locked.
> + *
> + * If the function returns 1, the caller is required to invoke
> + * __vma_exit_exclusive_locked() once the exclusive state is no longer required.
> + *
> + * If state is set to something other than TASK_UNINTERRUPTIBLE, the function
> + * may also return -EINTR to indicate a fatal signal was received while waiting.
>   */
> -static inline int __vma_enter_locked(struct vm_area_struct *vma,
> +static int __vma_enter_exclusive_locked(struct vm_area_struct *vma,
>  		bool detaching, int state)
>  {
>  	int err;
> @@ -85,13 +109,10 @@ static inline int __vma_enter_locked(struct vm_area_struct *vma,
>  		   refcount_read(&vma->vm_refcnt) == tgt_refcnt,
>  		   state);
>  	if (err) {
> -		bool detached;
> -
> -		__vma_exit_locked(vma, &detached);
> -		if (detached) {
> +		if (__vma_exit_exclusive_locked(vma)) {
>  			/*
>  			 * The wait failed, but the last reader went away
> -			 * as well.  Tell the caller the VMA is detached.
> +			 * as well. Tell the caller the VMA is detached.
>  			 */
>  			WARN_ON_ONCE(!detaching);
>  			err = 0;
> @@ -108,7 +129,7 @@ int __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq,
>  {
>  	int locked;
>  
> -	locked = __vma_enter_locked(vma, false, state);
> +	locked = __vma_enter_exclusive_locked(vma, false, state);
>  	if (locked < 0)
>  		return locked;
>  
> @@ -120,12 +141,9 @@ int __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq,
>  	 */
>  	WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
>  
> -	if (locked) {
> -		bool detached;
> -
> -		__vma_exit_locked(vma, &detached);
> -		WARN_ON_ONCE(detached); /* vma should remain attached */
> -	}
> +	/* vma should remain attached. */
> +	if (locked)
> +		WARN_ON_ONCE(__vma_exit_exclusive_locked(vma));
>  
>  	return 0;
>  }
> @@ -145,12 +163,12 @@ void vma_mark_detached(struct vm_area_struct *vma)
>  	detached = __vma_refcount_put(vma, NULL);
>  	if (unlikely(!detached)) {
>  		/* Wait until vma is detached with no readers. */
> -		if (__vma_enter_locked(vma, true, TASK_UNINTERRUPTIBLE)) {
> +		if (__vma_enter_exclusive_locked(vma, true, TASK_UNINTERRUPTIBLE)) {
>  			/*
>  			 * Once this is complete, no readers can increment the
>  			 * reference count, and the VMA is marked detached.
>  			 */
> -			__vma_exit_locked(vma, &detached);
> +			detached = __vma_exit_exclusive_locked(vma);
>  			WARN_ON_ONCE(!detached);
>  		}
>  	}

