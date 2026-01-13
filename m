Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2103921F6
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Jan 2026 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312782; cv=none; b=OH5P2C6oDyluGa+MkXfPgc/1nHcV0srPjIgyc9IC+Tcb0YjawHvupcJAKdKY9QMsc77WKz3awVUzJpLG92lovDDAlN3VAd42BBQdNiXgSYEb79Rkb6O2nGxQOR7Xyiasy/6DRrHgJdPR6LAkLy64Ej6z1Uno7wu7LhOj/yQNfz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312782; c=relaxed/simple;
	bh=DYcgB1W2ixwboOHHle2/6V3Qcy1cobHs4KreiDncyRI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RD1DqoTskhuEgB7hZ+khkcw+31EoZiNJs8A9Bi5HLYAFGyWFdO02sccjfGwAtcAmiccmtnE78/RBUnzOBPdEFtaiyKUUBBfgkX3WlkUjYwYync8TwJbD9/mNSLsZX5TY78THIg0NMhi8yALtkobrg4GId+IrdeqXkPvcELxelSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EFlaAwY7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vOW8eTPd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EFlaAwY7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vOW8eTPd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EFlaAwY7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vOW8eTPd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EFlaAwY7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vOW8eTPd"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A356033681;
	Tue, 13 Jan 2026 13:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768312778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsxGz7lXxf9Fc7o+3YTmQDIIh2zdHHfX8+mDLHhYXuY=;
	b=EFlaAwY75zzBevnmi4U8yTk0gl++rzWcCywlgFbs+kNoT3c7aOkv+lb5xikamLmKm9h0UW
	J+lhtEMWUczsEOe0IZNo9aFhVctN9csVOhOSWtXHHIhSON9vU0Okp1OZa2OaYtbFNg1Orb
	c8tLcVLpkZ3qIcDj5I8ubVMGakQUxJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768312778;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsxGz7lXxf9Fc7o+3YTmQDIIh2zdHHfX8+mDLHhYXuY=;
	b=vOW8eTPd4fmF22JWfMzdk724fqgp2bTTyWjjn5g6EBh52VRgWGaWh6P0u1/mIqm3WJrSrj
	s+/1xhbkC21JMkBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EFlaAwY7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vOW8eTPd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768312778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsxGz7lXxf9Fc7o+3YTmQDIIh2zdHHfX8+mDLHhYXuY=;
	b=EFlaAwY75zzBevnmi4U8yTk0gl++rzWcCywlgFbs+kNoT3c7aOkv+lb5xikamLmKm9h0UW
	J+lhtEMWUczsEOe0IZNo9aFhVctN9csVOhOSWtXHHIhSON9vU0Okp1OZa2OaYtbFNg1Orb
	c8tLcVLpkZ3qIcDj5I8ubVMGakQUxJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768312778;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsxGz7lXxf9Fc7o+3YTmQDIIh2zdHHfX8+mDLHhYXuY=;
	b=vOW8eTPd4fmF22JWfMzdk724fqgp2bTTyWjjn5g6EBh52VRgWGaWh6P0u1/mIqm3WJrSrj
	s+/1xhbkC21JMkBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FB3E3EA63;
	Tue, 13 Jan 2026 13:59:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bPbZIspPZmnvMAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 13 Jan 2026 13:59:38 +0000
Message-ID: <ce970598-fbef-4b58-bde6-fb099f1cb6be@suse.cz>
Date: Tue, 13 Jan 2026 14:59:38 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slab: fix kmalloc_nolock() context check for PREEMPT_RT
From: Vlastimil Babka <vbabka@suse.cz>
To: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>, lgoncalv@redhat.com
Cc: akpm@linux-foundation.org, ast@kernel.org, bigeasy@linutronix.de,
 cl@gentwo.org, clrkwllms@kernel.org, david.hunter.linux@gmail.com,
 harry.yoo@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-rt-devel@lists.linux.dev, rientjes@google.com,
 roman.gushchin@linux.dev, rostedt@goodmis.org, skhan@linuxfoundation.org,
 syzbot+b1546ad4a95331b2101e@syzkaller.appspotmail.com,
 Hao Li <hao.li@linux.dev>
References: <aUVTJyd74OoCtSyN@redhat.com>
 <20251219135143.7337-1-swarajgaikwad1925@gmail.com>
 <56598d76-02ca-490f-a100-0f223fb5717e@suse.cz>
Content-Language: en-US
In-Reply-To: <56598d76-02ca-490f-a100-0f223fb5717e@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.01
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linutronix.de,gentwo.org,gmail.com,oracle.com,vger.kernel.org,kvack.org,lists.linux.dev,google.com,linux.dev,goodmis.org,linuxfoundation.org,syzkaller.appspotmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[b1546ad4a95331b2101e];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A356033681
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On 1/5/26 8:19 PM, Vlastimil Babka wrote:
> On 12/19/25 14:51, Swaraj Gaikwad wrote:
>> I agree that we can simplify this. I think !preemptible() would be
>> the most descriptive choice here, as it directly expresses the
>> constraint, we cannot take a sleeping lock when preemption is
>> disabled.
>> The updated check would be:
>>     if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
>>
>> I'll send a v2 with this change unless there are objections.

Ping? Are you planning to? Otherwise we have to do it ourselves as we
can't leave things broken?

Also Sebastian do you agree? Thanks.

> I think it's the best solution for now, so please do. We can change it back
> later with sheaves, as Hao Li pointed out. It will limit PREEMPT_RT
> kmalloc_nolock() for now. Steven explained to me it's the tracepoints
> disabling preemption, but that will be also improved soon:
> 
> https://lore.kernel.org/all/20251219120607.7371034e@gandalf.local.home/
> 
> 
>> Swaraj
> 

