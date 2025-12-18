Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899432E3360
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Dec 2025 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766044317; cv=none; b=CVElQ+031mvhxdcGm6SPnllZZbt7Z8pvjA6GEYspjmqiu/oGqVBmK3s46YVxE01bTeS3mJ2YNuC7pRP+dPMwNo7naEEc+9DF1HMqXuFR7c4YkWER1Q2SKJfc+SkHUoG7h40VMMCaIGKiAN2Qc08Nb4nIXmmAdch2mrUUwNJZs/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766044317; c=relaxed/simple;
	bh=xKllaczr+QwMHef82Z7J0M4Hkf2HX4n5ZGD+S5ZFOKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJxZxsrd7hBB7r3TqpEX7jEC/6LYnzC8UW+08GY4qgVUfEXHYwdSt0iHSbQeYRNYMpvV1go/y2ARCqh9Xs4JdtdFVhE1Psnk/PSq/gozNH1ewAJuZHDDp5u357PjQO5RVagMgvJSqNo4QgoScdvuqssHz9l6zoA220poVHlKd6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yulxcs0E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VkG2oQg1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KWFQUgcN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R1h2VVnd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yulxcs0E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VkG2oQg1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KWFQUgcN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R1h2VVnd"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC3D0336E3;
	Thu, 18 Dec 2025 07:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766044314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Qj9TGZ/7LLeJN5JCas/6jSdNR1umkabrxnMSewPfrPY=;
	b=Yulxcs0EZYRUKAQOUDStV3SROc49T4/MJLq51M4FHfBOiBka21LSX3EG+QjcxeK7XgJ4mY
	IAb6KZmIWT+4R9czFHhcLzc9D9jdMBVUYhNQpMQ+A1Ed0hg/BjxEsBnvDWsgLhvJ5kH3lV
	iRY4CjfYScljWAqPLz2koJEtiyoSEhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766044314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Qj9TGZ/7LLeJN5JCas/6jSdNR1umkabrxnMSewPfrPY=;
	b=VkG2oQg1Z6xph6w0yQY8raXDkPdw7B1ayPYoJT6MgoAGyXy+uNEv/+VWY9IAr70dL4jabu
	L3k5iozwI99i+PCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766044312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Qj9TGZ/7LLeJN5JCas/6jSdNR1umkabrxnMSewPfrPY=;
	b=KWFQUgcNAvfC8MNfkqa5cdDIgElH8Uh4zgcJI3XOMFGVH6szHd6fxSSrXdJQTQZbVUWPvn
	nXErcyCZbd2DhaBDImxDWBdAVs3G29JYspFQgsxWX+qYqPoLJcOfbchO2bMDXN3II5XZ4n
	gIpodE2+/BTzSk8JxNewnO8fPwDGWso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766044312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Qj9TGZ/7LLeJN5JCas/6jSdNR1umkabrxnMSewPfrPY=;
	b=R1h2VVndmaQbmfIkUAkuw4InbqgEJS74T6peDr7SBtn0Qm3RwOMXt0BAPD7SKUhKoRiV9a
	lkgjyKlgckNT6YDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94ECB3EA63;
	Thu, 18 Dec 2025 07:51:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GiPwI5iyQ2mjDAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 18 Dec 2025 07:51:52 +0000
Message-ID: <586d24f9-a54d-4c14-bd25-fed18423d709@suse.cz>
Date: Thu, 18 Dec 2025 08:51:52 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: mmu: avoid allocating pages while
 installing ng-mapping for KPTI
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, Yeoreum Yun <yeoreum.yun@arm.com>,
 catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
 david@kernel.org, kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
 dev.jain@arm.com, yang@os.amperecomputing.com, chaitanyas.prakash@arm.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20251217182007.2345700-1-yeoreum.yun@arm.com>
 <20251217182007.2345700-3-yeoreum.yun@arm.com>
 <731e3f48-e0a3-4c89-a13a-65ef37faa443@arm.com>
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
In-Reply-To: <731e3f48-e0a3-4c89-a13a-65ef37faa443@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.27 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.17)[-0.832];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.27

On 12/17/25 20:03, Ryan Roberts wrote:
> On 17/12/2025 18:20, Yeoreum Yun wrote:
>> The current __kpti_install_ng_mappings() allocates a temporary PGD
>> while installing the NG mapping for KPTI under stop_machine(),
>> using GFP_ATOMIC.
>> 
>> This is fine in the non-PREEMPT_RT case. However, it becomes a problem
>> under PREEMPT_RT because generic memory allocation/free APIs
>> (e.g., pgtable_alloc(), __get_free_pages(), etc.) cannot be invoked
>> in a non-preemptible context, except for the *_nolock() variants.
>> These generic allocators may sleep due to their use of spin_lock().
>> 
>> In other words, calling __get_free_pages(), even with GFP_ATOMIC,
>> is not allowed in __kpti_install_ng_mappings(), which is executed by
>> the stopper thread where preemption is disabled under PREEMPT_RT.
>> 
>> To address this, preallocate the page needed for the temporary PGD
>> before invoking __kpti_install_ng_mappings() via stop_machine().
>> 
>> Fixes: 47546a1912fc ("arm64: mm: install KPTI nG mappings with MMU enabled")
>> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
>> ---
>>  arch/arm64/mm/mmu.c | 22 +++++++++++++---------
>>  1 file changed, 13 insertions(+), 9 deletions(-)
>> 
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index e4e6c7e0a016..69d9651de0cd 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1360,7 +1360,7 @@ static phys_addr_t __init kpti_ng_pgd_alloc(enum pgtable_type type)
>>  	return kpti_ng_temp_alloc;
>>  }
>>  
>> -static int __init __kpti_install_ng_mappings(void *__unused)
>> +static int __init __kpti_install_ng_mappings(void *data)
>>  {
>>  	typedef void (kpti_remap_fn)(int, int, phys_addr_t, unsigned long);
>>  	extern kpti_remap_fn idmap_kpti_install_ng_mappings;
>> @@ -1368,10 +1368,9 @@ static int __init __kpti_install_ng_mappings(void *__unused)
>>  
>>  	int cpu = smp_processor_id();
>>  	int levels = CONFIG_PGTABLE_LEVELS;
>> -	int order = order_base_2(levels);
>>  	u64 kpti_ng_temp_pgd_pa = 0;
>>  	pgd_t *kpti_ng_temp_pgd;
>> -	u64 alloc = 0;
>> +	u64 alloc = *(u64 *)data;
>>  
>>  	if (levels == 5 && !pgtable_l5_enabled())
>>  		levels = 4;
>> @@ -1382,8 +1381,6 @@ static int __init __kpti_install_ng_mappings(void *__unused)
>>  
>>  	if (!cpu) {
>>  		int ret;
>> -
>> -		alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
>>  		kpti_ng_temp_pgd = (pgd_t *)(alloc + (levels - 1) * PAGE_SIZE);
>>  		kpti_ng_temp_alloc = kpti_ng_temp_pgd_pa = __pa(kpti_ng_temp_pgd);
>>  
>> @@ -1414,16 +1411,17 @@ static int __init __kpti_install_ng_mappings(void *__unused)
>>  	remap_fn(cpu, num_online_cpus(), kpti_ng_temp_pgd_pa, KPTI_NG_TEMP_VA);
>>  	cpu_uninstall_idmap();
>>  
>> -	if (!cpu) {
>> -		free_pages(alloc, order);
>> +	if (!cpu)
>>  		arm64_use_ng_mappings = true;
>> -	}
>>  
>>  	return 0;
>>  }
>>  
>>  void __init kpti_install_ng_mappings(void)
>>  {
>> +	int order = order_base_2(CONFIG_PGTABLE_LEVELS);
>> +	u64 alloc;
>> +
>>  	/* Check whether KPTI is going to be used */
>>  	if (!arm64_kernel_unmapped_at_el0())
>>  		return;
>> @@ -1436,8 +1434,14 @@ void __init kpti_install_ng_mappings(void)
>>  	if (arm64_use_ng_mappings)
>>  		return;
>>  
>> +	alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
> 
> I don't think this requires GFP_ATOMIC now?

Do you mean it's fine to use GFP_KERNEL now, or still not, and you mean that
GFP_NOWAIT is sufficient?

> With that removed:
> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> 
>> +	if (!alloc)
>> +		panic("Failed to alloc page tables\n");
>> +
>>  	init_idmap_kpti_bbml2_flag();
>> -	stop_machine(__kpti_install_ng_mappings, NULL, cpu_online_mask);
>> +	stop_machine(__kpti_install_ng_mappings, &alloc, cpu_online_mask);
>> +
>> +	free_pages(alloc, order);
>>  }
>>  
>>  static pgprot_t __init kernel_exec_prot(void)
> 

