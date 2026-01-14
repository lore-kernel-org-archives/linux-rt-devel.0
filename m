Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A9939A803
	for <linux-rt-devel@lists.linux.dev>; Wed, 14 Jan 2026 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768396472; cv=none; b=tSS9+NVGV/rTDZpQU8bSfrQClew3042C7ssOjLUKRqIwPIIOdwT5UOl7yp9EBd79g/+ey3o7ckTY2RhNokwlsBxfJhu41WXX9nH9Mpww68tG2m7m3yP+57bspyisQSJEr/A0XbwZMh/ARW4IWawECIe9cREbbcO/o73koR1Jvks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768396472; c=relaxed/simple;
	bh=FPkV34hmvhvedkTDS16DCGzqsr8kYrsKkQIewHotFzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oeYPQ/zexcH6JbQBPZqTNrCuYsHB9m6fSpIUf8SDor7p8Yo2DYYU4QoQcgrgdnpf/ovV62we8seUJ35IcBFXUI/sHYKpy8jK8vKNUtnLzmd4bAwUShesZ1lpAcd7An2hHT2XLmmyM/dJbSgpV0/sNzeAjN9sHIDtUN/DcIDPPiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0hhvUfpL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kg0VZ14t; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0hhvUfpL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kg0VZ14t; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0hhvUfpL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kg0VZ14t";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0hhvUfpL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kg0VZ14t"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 55BD03402B;
	Wed, 14 Jan 2026 13:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768396469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FsTG5iVeM/SDmd5f2bL2EZ5iVc5vb5sMbUUarUjEyRY=;
	b=0hhvUfpLf9D05/9CTU6aSEENOoKkyCOCKWSVL6wFyaZe4cYREGkq6JaI7olAj3VUDtFhNV
	u4iksMIyM5bnn8ovN+sTZTifvJaaFmbBdefqlv6rGPghGeuFhj1nOahwF+IVQajNk16lmS
	p5guWt8XbwZwVBmYSaNxb7H0khjEylQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768396469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FsTG5iVeM/SDmd5f2bL2EZ5iVc5vb5sMbUUarUjEyRY=;
	b=kg0VZ14tKCBNG9hn1SQQ/+S1iZXh2JmVMyFUz1fTYA29aKuEPwJOkVm/vFhkBycmACbC3T
	qhR8Oz/QGjnfHcBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0hhvUfpL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kg0VZ14t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768396469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FsTG5iVeM/SDmd5f2bL2EZ5iVc5vb5sMbUUarUjEyRY=;
	b=0hhvUfpLf9D05/9CTU6aSEENOoKkyCOCKWSVL6wFyaZe4cYREGkq6JaI7olAj3VUDtFhNV
	u4iksMIyM5bnn8ovN+sTZTifvJaaFmbBdefqlv6rGPghGeuFhj1nOahwF+IVQajNk16lmS
	p5guWt8XbwZwVBmYSaNxb7H0khjEylQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768396469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FsTG5iVeM/SDmd5f2bL2EZ5iVc5vb5sMbUUarUjEyRY=;
	b=kg0VZ14tKCBNG9hn1SQQ/+S1iZXh2JmVMyFUz1fTYA29aKuEPwJOkVm/vFhkBycmACbC3T
	qhR8Oz/QGjnfHcBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27FCA3EA63;
	Wed, 14 Jan 2026 13:14:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8+l2CbWWZ2kDfQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 14 Jan 2026 13:14:29 +0000
Message-ID: <f5cc5a84-57fc-4fd4-aa74-fc89fdcbb042@suse.cz>
Date: Wed, 14 Jan 2026 14:14:28 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] slab: fix kmalloc_nolock() context check for
 PREEMPT_RT
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Alexei Starovoitov <ast@kernel.org>,
 "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT"
 <linux-rt-devel@lists.linux.dev>, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com,
 syzbot+b1546ad4a95331b2101e@syzkaller.appspotmail.com
References: <20260113150639.48407-1-swarajgaikwad1925@gmail.com>
 <20260113180036.Zl8j3vIY@linutronix.de>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20260113180036.Zl8j3vIY@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_RCPT(0.00)[b1546ad4a95331b2101e];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gentwo.org,google.com,linux.dev,oracle.com,kernel.org,goodmis.org,kvack.org,vger.kernel.org,lists.linux.dev,linuxfoundation.org,gmail.com,syzkaller.appspotmail.com];
	FREEMAIL_TO(0.00)[linutronix.de,gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 55BD03402B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On 1/13/26 19:00, Sebastian Andrzej Siewior wrote:
> 
> I would say that despite the _nolock() suffix a local_lock() is still
> acquired. The !PREEMPT_RT does a trylock.
> 
> As I noticed this myself today while looking at other patches, was the
> trylock removed on RT by accident, was it there only in an earlier
> version which was never merged and will it ever come back so we can go
> back to !nmi || !hardirq?

IIRC there was no version that would do always a trylock on RT (or maybe
there was some early one but run into trouble quickly?). The problem was
converting the slub code to deal with situations where initially trylock
suceeds in the given context, but then it's dropped and later needed again,
and failing that later trylock would be too complex to unwind. So instead we
do the local_lock_is_locked() check upfront and then trust that all nested
local_lock_cpu_slab()'s can't fail. And unfortunately this doesn't very play
well with RT semantics.

> 
>> +		 */
>>  		return NULL;
>>  retry:
>>  	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
>> 
> 
> Sebastian

