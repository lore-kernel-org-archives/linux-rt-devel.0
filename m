Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9079129E0FD
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185290; cv=none; b=DhGNzKYP/c+lF/CZQdRWlLLz+ZMN0qHn1sCwb3N0cullKeFlEm18Qjw6zZyINNEQkH/Q5u8o0pOyxlhbk2itLPDcGpZYF6b3/igLu9ZwofVjJLjLJ4LUpH6aRwdyUsMNNMT/qNpl4NnJBlgbT+faoHTgowGIs40+cbq0M/BF+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185290; c=relaxed/simple;
	bh=RYNOwP0PydbqXkBtUeNfoM73vFwUWIJl+te4IxjSQRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYGB8KvU1d6DCwK4vK9Ho6wADz17j2wKLN1qCi9/K0S0F6QKInYYuY3uHtLkSrXU6Vv+JLH1OHcd2zpkVqZMjDQVwMVxrLPp41i3+pAkPVByoiAGj+f+oPt8QlyobenKNB2eFu2M9H4e88S7qe1KuRTOoNp6Wb5alQQPG9HLRkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kiL0wXJJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WYSEuCkZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kiL0wXJJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WYSEuCkZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kiL0wXJJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WYSEuCkZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kiL0wXJJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WYSEuCkZ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 96E3C5BCCF;
	Fri, 23 Jan 2026 16:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769185286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L58AJIr91oTMKf0PXTG1TbeTEeGFV9i4xfX9fFVLhOQ=;
	b=kiL0wXJJgh1HZq4TCsure9RERmyqII/kPjxCj0kIkQLBiE242PuXZ3NdmN1xgGJ41Jhas1
	IX9XioeqvhtuKVp4Y4/0oRdACHfLmwZBu5HPfG1Mik5FaZK0k1xHqTScO5NDFmVSttKrdj
	KLiereNzlxSMJ07q1vMvgC44Ag96riI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769185286;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L58AJIr91oTMKf0PXTG1TbeTEeGFV9i4xfX9fFVLhOQ=;
	b=WYSEuCkZ4kAULpe5Rjq1HbLNcgx3KwRNfSAE/H4jyWWJJiGYEXW0r0k+sDTJ6MSMWD0MBI
	LTTJ7lLo2MfeTSDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kiL0wXJJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WYSEuCkZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769185286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L58AJIr91oTMKf0PXTG1TbeTEeGFV9i4xfX9fFVLhOQ=;
	b=kiL0wXJJgh1HZq4TCsure9RERmyqII/kPjxCj0kIkQLBiE242PuXZ3NdmN1xgGJ41Jhas1
	IX9XioeqvhtuKVp4Y4/0oRdACHfLmwZBu5HPfG1Mik5FaZK0k1xHqTScO5NDFmVSttKrdj
	KLiereNzlxSMJ07q1vMvgC44Ag96riI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769185286;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L58AJIr91oTMKf0PXTG1TbeTEeGFV9i4xfX9fFVLhOQ=;
	b=WYSEuCkZ4kAULpe5Rjq1HbLNcgx3KwRNfSAE/H4jyWWJJiGYEXW0r0k+sDTJ6MSMWD0MBI
	LTTJ7lLo2MfeTSDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 697181395E;
	Fri, 23 Jan 2026 16:21:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9QNXGQagc2nMGwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 23 Jan 2026 16:21:26 +0000
Message-ID: <b267b699-f312-4387-8dc0-a14efe72561a@suse.cz>
Date: Fri, 23 Jan 2026 17:21:26 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 08/10] mm/vma: improve and document
 __is_vma_write_locked()
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com>
 <70dcf80f79ecd00a750ea17101061b0949119429.1769086312.git.lorenzo.stoakes@oracle.com>
 <CAJuCfpF1LthyP2FR4T8iDd+zOi1WAjqma2KBkHcCJsOjm+s32A@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <CAJuCfpF1LthyP2FR4T8iDd+zOi1WAjqma2KBkHcCJsOjm+s32A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,oracle.com,suse.com,linux.dev,google.com,kvack.org,vger.kernel.org,lists.linux.dev,infradead.org,redhat.com,gmail.com,linutronix.de,goodmis.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,oracle.com:email]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 96E3C5BCCF
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On 1/22/26 22:55, Suren Baghdasaryan wrote:
> On Thu, Jan 22, 2026 at 5:02 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
>>
>> The function is a little confusing, clean it up a little then add a
>> descriptive comment.
> 
> I appreciate the descriptive comment but what exactly was confusing in
> this function?
> 
>>
>> No functional change intended.
>>
>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> ---
>>  include/linux/mmap_lock.h | 23 ++++++++++++++++++-----
>>  1 file changed, 18 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
>> index 873bc5f3c97c..b00d34b5ad10 100644
>> --- a/include/linux/mmap_lock.h
>> +++ b/include/linux/mmap_lock.h
>> @@ -252,17 +252,30 @@ static inline void vma_end_read(struct vm_area_struct *vma)
>>         vma_refcount_put(vma);
>>  }
>>
>> -/* WARNING! Can only be used if mmap_lock is expected to be write-locked */
>> -static inline bool __is_vma_write_locked(struct vm_area_struct *vma, unsigned int *mm_lock_seq)
>> +/*
>> + * Determine whether a VMA is write-locked. Must be invoked ONLY if the mmap
>> + * write lock is held.
>> + *
>> + * Returns true if write-locked, otherwise false.
>> + *
>> + * Note that mm_lock_seq is updated only if the VMA is NOT write-locked.

Could it also say to what it's updated to? Or is it too obvious?

> 
> True, this does not result in a functional change because we do not
> use mm_lock_seq if __is_vma_write_locked() succeeds. However this
> seems to add additional gotcha that you need to remember. Any reason
> why?

Actually I wonder if it's really worth returning the mm_lock_seq and passing
it to __vma_start_write(), which could just determine it on its own. It
would simplify things.

>> + */
>> +static inline bool __is_vma_write_locked(struct vm_area_struct *vma,
>> +                                        unsigned int *mm_lock_seq)
>>  {
>> -       mmap_assert_write_locked(vma->vm_mm);
>> +       struct mm_struct *mm = vma->vm_mm;
>> +       const unsigned int seq = mm->mm_lock_seq.sequence;
>> +
>> +       mmap_assert_write_locked(mm);
>>
>>         /*
>>          * current task is holding mmap_write_lock, both vma->vm_lock_seq and
>>          * mm->mm_lock_seq can't be concurrently modified.
>>          */
>> -       *mm_lock_seq = vma->vm_mm->mm_lock_seq.sequence;
>> -       return (vma->vm_lock_seq == *mm_lock_seq);
>> +       if (vma->vm_lock_seq == seq)
>> +               return true;
>> +       *mm_lock_seq = seq;
>> +       return false;
>>  }
>>
>>  int __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq,
>> --
>> 2.52.0

