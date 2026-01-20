Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEBC38B9B5
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Jan 2026 21:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768944500; cv=none; b=ER/4BwMeIlYh8gHN2GHqlUBVLJb+bW2CY+5jkPOoXLb0RkQzbE4/xfCp9tIDYE8ewEgIpgZttslQKs4SZaTDrWJo0cNE0bMB98dekE19g1gbi3eBtHWGF4Bc4IjVR12CWwIUA+CX6yA9KcR332JxddpM9lu7bsjtYNNqbq75aVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768944500; c=relaxed/simple;
	bh=v20egT4Zz4YXYvJTKXJWq9/9xDRqRwVSYy3tjzvCDEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkFDyACgOyPAYPAET46oCVbMuiZzHblgo/uNr+oTCzcraHAZSSQ9d9CuyFFwq166okTOdBBmVo+gjzx9qj7Won/JnSOLFR5KewbCVawp9X8IZ9MFg5XrZoeLt/Lp+GAatjHc6btLqf7X2/DlwSjEz8+FolLJPmGtZQ7/D0AWESc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ukFmTDUU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K/Z8I8ag; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ukFmTDUU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K/Z8I8ag; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ukFmTDUU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K/Z8I8ag";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ukFmTDUU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K/Z8I8ag"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5B84533684;
	Tue, 20 Jan 2026 21:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768944496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GcAunUIhJXMUoQv1m80mheOHzlZ+Ht6+5c4dw4DMriQ=;
	b=ukFmTDUUWGubsTGEGlpDs26O7n22s1NFpOwstBhY9w3aq5vB5XQdqFZagsSMG+bwXDZaO/
	UpDfgWOss8VLPwj7FLfgDg1ry1P3zMTuvj0KT5LXxiNSCNP1PxS1Ah/3fqN5CsQZHp7p5w
	neAT1c3+Ixzr42RxLryZ8FeVoZxU/Lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768944496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GcAunUIhJXMUoQv1m80mheOHzlZ+Ht6+5c4dw4DMriQ=;
	b=K/Z8I8ag4bVtKifrfxpIZe8OBQkrveGd7t1sLAXBUK+vBSXouMDDMChzobYgeJKdhUtvKa
	gHE2JVkZXqZlGyCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ukFmTDUU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="K/Z8I8ag"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768944496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GcAunUIhJXMUoQv1m80mheOHzlZ+Ht6+5c4dw4DMriQ=;
	b=ukFmTDUUWGubsTGEGlpDs26O7n22s1NFpOwstBhY9w3aq5vB5XQdqFZagsSMG+bwXDZaO/
	UpDfgWOss8VLPwj7FLfgDg1ry1P3zMTuvj0KT5LXxiNSCNP1PxS1Ah/3fqN5CsQZHp7p5w
	neAT1c3+Ixzr42RxLryZ8FeVoZxU/Lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768944496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GcAunUIhJXMUoQv1m80mheOHzlZ+Ht6+5c4dw4DMriQ=;
	b=K/Z8I8ag4bVtKifrfxpIZe8OBQkrveGd7t1sLAXBUK+vBSXouMDDMChzobYgeJKdhUtvKa
	gHE2JVkZXqZlGyCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CA413EA63;
	Tue, 20 Jan 2026 21:28:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C2d2CXDzb2n/dgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 20 Jan 2026 21:28:16 +0000
Message-ID: <f7ed3125-e7ce-45b0-a077-a2979a6238b3@suse.cz>
Date: Tue, 20 Jan 2026 22:28:15 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/vma: use lockdep where we can, reduce
 duplication
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
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
References: <cover.1768855783.git.lorenzo.stoakes@oracle.com>
 <bd410fd91d22eef37f9b617327cafce33b267b09.1768855783.git.lorenzo.stoakes@oracle.com>
 <30f843d9-03cf-4c7c-8a29-8e11b12e47e4@suse.cz>
 <61ca35cd-5c08-4196-89b6-ec3feda69e36@lucifer.local>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <61ca35cd-5c08-4196-89b6-ec3feda69e36@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,oracle.com,google.com,suse.com,linux.dev,kvack.org,vger.kernel.org,lists.linux.dev,infradead.org,redhat.com,gmail.com,linutronix.de,goodmis.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 5B84533684
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On 1/20/26 18:49, Lorenzo Stoakes wrote:
> On Tue, Jan 20, 2026 at 02:53:30PM +0100, Vlastimil Babka wrote:
>> On 1/19/26 21:59, Lorenzo Stoakes wrote:
>> > We introduce vma_is_read_locked(), which must deal with the case in which
>> > VMA write lock sets refcnt to VMA_LOCK_OFFSET or VMA_LOCK_OFFSET +
>> > 1. Luckily is_vma_writer_only() already exists which we can use to check
>> > this.
>>
>> So I think there's a bit of a caveat in that
>>
>> - is_vma_writer_only() may be a false positive if there is a temporary
>> reader of a detached vma (per comments in vma_mark_detached() and
>> vma_mark_detached())
> 
> vma_mark_detached() and vma_mark_attached() I sasume you mean.

Right.

> OK so this is all very confusing indeed.
> 
> This function is _only_ referring to the situation between
> __vma_enter_locked() and __vma_exit_locked().
> 
> Despite their names, suggesting maybe they happen on lock and unlock
> respectively, that's not the case, they're both invoked on lock and enter
> on start of TAKING lock and exit on completion of TAKING the
> lock.

IIUC yes, for the vma "write lock".

> It seems __vma_enter_locked() is more about getting into this state with
> refcnt equal to VMA_LOCK_OFFSET (detaching - note elsewhere we say detached
> of course) or VMA_LOCK_OFFSET + 1 if attached and waiting on readers who
> are spuriously increasing the reference count.

Yes.

> So fundamentally is_vma_writer_only() is actually asking 'are we in the
> midst of a VMA write lock acquisiton having finally set the VMA's refcnt to
> VMA_LOCK_OFFSET or VMA_LOCK_OFFSET+1 but haven't yet completed acquiring
> the lock' - e.g. having not yet called __vma_exit_locked().

IIUC in the current code it's not used in that "are *we* in the midst..."
sense but "is there a writer in that phase that we are supposed to wake up
because we are the last reader", where a rare false positive answer only
results in an unnecessary wakeup of said wanna-be writer, but nothing worse.

And AFAIU this patch tries to reuse the function to ask "is the vma read
locked?" (and we presume it's by us).

> With __vma_enter_locked() called from:
> 
> vma_start_write() / vma_start_write_killable()
> -> __vma_start_write()
> -> __vma_enter_locked()
> 
> vma_mark_detached()
> -> __vma_enter_locked()
> 
> OK so in __vma_enter_locked() we add VMA_LOCK_OFFSET but then wait until we
> get to either VMA_LOCK_OFFSET + 1 (attached) or VMA_LOCK_OFFSET (detached),
> since presumably refcnt == 0 is detached, refcnt == 1 means write lock
> finally acquired (but you have to check the sequence number).
> 
> And _there_ we could have spurious readers.

Yes.

> 
>>
>> - hence vma_is_read_locked() may be a false negative
> 
> Yup.
> 
>>
>> - hence vma_assert_locked() might assume wrongly that we should not assert
>> being a reader, so we vma_assert_write_locked() instead, and fail
> 
> Aside ->
> 
> 	Every time I come to this code it's like this - having to refresh
> 	my memory as to how any of it works, getting confused, etc.
> 
> 	This speaks to this being a broken abstraction similar to anon_vma.
> 
> 	What I mean by leaked abstraction is that you seem to need to
> 	maintain the _implementation_ context in your head to be able to
> 	correctly implement anything. We simply are not abstracting details
> 	here really well at all.

I think this would be true if it was applied to users of the high-level API
of the code - actual locking and unlocking for read/write. Do they have to
care about the implementation details? Hopefully not.

Here we have to think about the implementation because we are trying to
improve the API (to add assertions) so that's not surprising? If your
complaing is about an "intermediate" abstractions level like the
"is_vma_writer_only()" function then yeah it's far from perfect.

> 	The fact I got this wrong despite staring at this code for ages is
> 	indicative of that.
> 
> 	Also the fact an ostensibly simple series has turned into a
> 	'restore the context' discussion this long and taken this many
> 	hours is further suggestive.
> 
> 	I think we can do better. I'd rather not do more 'cleanup' series,
> 	but I think this badly needs it.
> 
> 	So maybe I'll convert this series into something that addresses
> 	some of this stuff.
> 
> <- Aside
> 
> 
>>
>> Howevever the above should mean it could be only us who is the temporary
>> reader. And we are not going to use vma_assert_locked() during the temporary
>> reader part (in vma_start_read()).
> 
> I don't think so? Spurious readers can arise at any time incrementing the
> refcnt via vma_start_read(), so the temporary readers could be anybody.
> 
> But they'd not get the read lock, and so shouldn't call anything asserting
> read lock.
> 
> Anyway I think my use of is_vma_writer_only() is just broken then.

AFAIU the whole thing (vma_assert_locked() after this patch) would be broken
in a case where we are really a reader and vma_is_read_locked() returns
false wrongly, and thus makes us perform vma_assert_write_locked() and fail.
So the scenarios with spurious readers can't cause that I think.

What I think could cause that is there being a writer (not us), causing
is_vma_writer_only() return true even when there's also a reader (us). And I
concluded that could happen only in case where we would be the spurious
reader racing with a detaching writer. But when we are in the temporary
spurious reader situation, we don't perform vma_is_read_locked() there.

> We _do_ need to account for the VMA write lock scenario here, but I think
> instead we should be good with refcnt > 1 && refcnt < VMA_LOCK_OFFSET no?

That check would tell us there is no writer. But there might be a writer
(not us) while we're a reader, and thus that check won't work as a signal
for "we must have the read lock"?

>> So it's probably fine, but maybe worth some comments to prevent people
>> getting suspicious and reconstructing this?
> 
> But yeah we shouldn't be asserting this anywhere during which this should
> be the case.
> 
> So hopefully the above resolves the issue?

I don't follow, but perhaps I misunderstood you above and it's late here now.

> It's still racey (write lock might have been acquired since we checked but
> that's just the nature of it.
> 
> But if we use lockdep as you mention we can actually do the same 'precise
> if lockdep, otherwise not so precise' approach in the stabilised check.
> 
> Let me respin.
>
>>
>> But I think perhaps also vma_assert_locked() could, with lockdep enabled
>> (similarly to vma_assert_stabilised() in patch 2), use the
>> "lock_is_held(&vma->vmlock_dep_map)" condition (without immediately
>> asserting it) for the primary reader vs writer decision, and not rely on
>> vma_is_read_locked()? Because lockdep has the precise information.
>>
>> It would likely make things more ugly, or require more refactoring, but
>> hopefully worthwhile?
> 
> Yeah good idea. Will do.

Ack, thanks.

> Maybe I need to make this into a broader refactoring series. Because this
> so badly needs it.

Yep :/

> Cheers, Lorenzo

