Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810789;
	b=fSamSVxcB6QdcNsIW8v11cEB9jqXsnuCSAbLf83126Eph33ssIh91EeuUJk7zIn5xgr0
	 esijRCH7FeHWmBcGSucXbiqmHFpzDrxZJHgKRD/Qek4f9YGxQBnSLnO6G7luUdtF/Io39
	 pMG9Ge2UwQQ1SihRPCvTsIBx4Z0kgch0xKYKE9OjODa5EAYlXQMTYbPDmCmfzdgYWVQAx
	 axM/xuXt+2yXF1qBqKMsA9o+Ork79fhxRjUucZr2/i0RW+naWY0RwJes7xAutuZ/p7afV
	 jWI1vLXlERgm+Eu2IEtZmKRO+nUMdk/v4Q0tAY2tuCZA3xaosdf/kB7PgF2CnSMX+uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=qxevzDe0ERznAZjpDl0rGSZzGbCrk7b/Nsjrdx1IHxQ=;
	b=Ziuh2EEHIvxgkJf2OfPpS5lHyatR4DikZYvtzg5NIfeOTK1si2xD92RVqCLpI3p27dbJ
	 QLmIDF4fEcBADS1EBLX/NdCL9lMjp+KgU35LI//CsGaxui7sQejDdoImJeAAWvIdN213W
	 HfoDRt6ovaMh69/lKYxqQbRjUVXTW/NQQSnk741mOLFXjlLJybyzECq3iYICdIEkkNJzs
	 kWGRv3Nv+OSdOcp6JH7K7DshEMClN+rolXXuI0Yqe77V1Lk9DGxYMU3uY0yGF6Xrgf4D8
	 p4oW2QInNH9Qr3NiSincIWwyaUqFWpaqPe76NkQfezzyZ+u9YLYbEIy5FXMbXTyV6Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MAoFwTuo;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA446082BE3
	for <linux-rt-devel@lists.linux.dev>; Wed,  4 Nov 2026 16:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EA446082BE3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MAoFwTuo
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e940d5d2beso4070235ad.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 04 Nov 2026 08:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793810789; x=1794415589; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qxevzDe0ERznAZjpDl0rGSZzGbCrk7b/Nsjrdx1IHxQ=;
        b=MAoFwTuoKw1OA5ieNq3kWkCl6SJ4m6wxVat4MFgG5RKKZGdcC/ogzt2kB5oBXZDC4L
         ZAMjSyLTiaDycFPQgoHicjR3CiVuMqYwa0GMmQIEcFrvALJxU3oNfI/xAGVj4qcixcV7
         5A74rj+KMgM4pQ0I/7lRzQisIngtHVUHxtiaJv6Q55oH9eu74DvgD6ndqxj1yU0AM2EW
         CbRdqOPbnux9y+RxwBkHVNIBOR9UBYco3/vF1EozUduWzwluRcBQ5rh9bFMJzzOlzwB6
         HwN8nYwMWFroWMl7kjlJnXTijvET7Pvh279qR3jBxQb3q8G0c9qKIKyarjokGxJZtT2s
         0tSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810789; x=1794415589;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qxevzDe0ERznAZjpDl0rGSZzGbCrk7b/Nsjrdx1IHxQ=;
        b=yMUBX/2MzWDJy23KTt4EFhxOfy+yqvc+1KbLWJE50KhBwLe0mLRwzzfIHp6qka+7Z/
         LWwQX2ckWK+5iBLnP0aUHqglVRRVWtjqWGz5SIWdeQjy9D/80gAe7mVCGMBd6uUYNxdu
         bvDY57wsmCErIFevoBAM5KZqA51zxGkne2vioCK07JMBHkP50MX2zzOIm2rVdtopyMRd
         exgukJ1522no9JP6NqLX9A5h3/xWKh6gJPVuHKLvFzbWZnGg9I2aL2h85gYC2ddtJibl
         yoVc96mX1dflaG5N6y+ltI6TkGAi6YdU0Lcey35wfA76ALSYVRnWwmspQWVBaerr7xla
         HdMg==
X-Forwarded-Encrypted: i=1; AKwUvBwkC2lHJbbjta8fvWLeb4zy4DztOpZcQ4dtexpdGdK9Z7NcM/EPgNos0K3xAUNxct5rYIAyyn5LA14w7j4MLA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9qLSGyn7LIN2E+qZF0vvm6tz8IQfECNWFE9dLeKI7OK17qFGch
	lfsh1X1qiNLpw1xBv/NUpTKkQSfsGP8avyp2GcXuMED99PXE1DIApThn
X-Gm-Gg: AYBFou07+Ld/Rj5u9tK2y9aHtt23d9UxOj4KPDHXh98HjInp1bcavj2v6FuwbLMdxBj
	bmneAdiOxdnQoDGn768nmwQhPrcUxedlPVBvWkUVorCJUQXZ29ISQdXeuqNIWUZzxNrLsA2WobI
	pzcRH50VyAD/3s/XYvVsUsdPQRi/WK3OEVBIRuXWw69U2yxehKlJjCIM4vYhmPNPZsF+Lsrpfmd
	/4qKZ8d2xfJwvsR4szlAMfIRoPk2x3jz0Oc/+Lk2DPEc3FxpPntoZaQ4RcRasXVbmfERhJG9EMs
	P/WST83pNlE32zAa8cQBmj1aKaDKmsQtXdaNzV893B9yZSrTNkolGLksf/1nEwZX7V7oCBawpvQ
	4DAEjLbW0LDM6on9VYX0Gto/vadLPUV/nCmPP3dDHKUF9NVW+XnxmuNwM4gfI40MMUXOYdvny7W
	//osigtaIEvZmNXjL1Q1//9zoxgGtFYJh2pfEIzP5cpm1CbitjEOYgYkcbBkN0UI8XhIcVyv1pz
	XG2FfNq249Z8MxG6IMkHAxk41PBpUXzsTcUJdptsHPtQyOCjs6XF4/BLCRBQ2qzVsur0qu1QxYN
	jBYLQuZ16991uu7R2lWD3t5Pk7wfJwBiUQROARcpDdH0tvCrfnLZvVLTUy4GeRQUg1bak+8DVFS
	9d+qRiI3x680QerJPqK8ZGp9y+tNAL1Ia52w=
X-Received: by 2002:a17:903:4b0e:b0:2e9:9a19:c54 with SMTP id d9443c01a7336-2eb3646ee38mr139469995ad.50.1793810788339;
        Wed, 04 Nov 2026 08:46:28 -0800 (PST)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed08bd4a3csm9983805ad.11.2026.11.04.08.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 08:46:27 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 16:46:26 +0000
Message-Id: <DMMKUQVDEM0N.322USN1ZSYMCU@gmail.com>
Subject: Re: [PATCH for-next-fixes v2 4/5] mm/slab: fix a deadlock in
 memcg_alloc_abort_single()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, "Harry Yoo"
 <harry@kernel.org>
Cc: "Johannes Weiner" <hannes@cmpxchg.org>, "Michal Hocko"
 <mhocko@kernel.org>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Shakeel
 Butt" <shakeel.butt@linux.dev>, "Muchun Song" <muchun.song@linux.dev>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Hao Li" <hao.li@linux.dev>,
 "Christoph Lameter" <cl@gentwo.org>, "David Rientjes"
 <rientjes@google.com>, "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 "Clark Williams" <clrkwllms@kernel.org>, "Steven Rostedt"
 <rostedt@goodmis.org>, <kernel-team@meta.com>, <cgroups@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, "Sashiko" <sashiko-bot@kernel.org>
In-Reply-To: <6441429b-eff2-485b-acf3-26c3034910ae@kernel.org>
References: <20261103-kmalloc-nolock-fixes-v2-0-19167cfe4779@kernel.org> <20261103-kmalloc-nolock-fixes-v2-4-19167cfe4779@kernel.org> <DMLSN9VHK0P3.2A97046A4YXGY@gmail.com> <auo5G__ac1qA9JRs@thinkstation> <DMLVUTB5J1RJ.2QKOUW6UB04ZM@gmail.com> <6441429b-eff2-485b-acf3-26c3034910ae@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Wed, Nov 04, 2026 at 07:35 AM Vlastimil Babka (SUSE) <vbabka@kernel.org> wrote:
>> I don't insist on kfree_nolock() there,
>> but can we try free_to_pcs() before defer_free() ?
>> Like:
>>
>> 	if (likely(allow_spin))
>> 		__slab_free(s, slab, object, object, 1, _RET_IP_);
>> 	else if (!can_free_to_pcs(slab) || !free_to_pcs(s, object, false))
>> 		defer_free(s, object);
>
> Why not try free_to_pcs with allow_spin as well then, and improve
> memcg_alloc_abort_single() for both contexts?

yep. Even better.
The bulk side does that already.
Like:

	if (likely(can_free_to_pcs(slab)) &&
	    likely(free_to_pcs(s, object, allow_spin)))
		return;

	if (likely(allow_spin))
		__slab_free(s, slab, object, object, 1, _RET_IP_);
	else
		defer_free(s, object);
?
