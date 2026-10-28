Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194919;
	b=sC2T+isbSU066IKp4ezssBP+0PFAxogff+UgHpwrmUKyq9I9nlgMTFLOQRiIaGAxhVTK
	 NWKLnuE7jTdKgbPa8nnRhL+W2NerGekWstrbLVSCiICMiIaBaW0uhe5svJj8fmeZ1AvA8
	 dXbygbvzjiXYlGvM/khpFm+QGKJDTBJl0y6WjUAnqnuNbznerxV3Uhbmvtewu9Dkv0c4N
	 +IztAUP57liUYgAJt/vVIA7aRrVI7myS4MHKhsFf8M7qTKDgmKa5sqh3bQTYF9rsQG1kO
	 9EqPbZ/2kIiNhEM6tsNq4iboFiJBLd7HIdg53LUWO4OF5+qj5DoTknxikVSIysaXZEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=1mZLWc84btDXl0MHk8lbS2Z2QDCAWwzGK7CzWjzphtY=;
	b=WCmnSIjNgt0GvziQZebq+b3WspZsP2JQrL8gMa1oS0izT8SnUK5WdSqInWJq7caqgcve
	 4cWghzIuhYPEHPkXMHp0QOyMSNEdxciZtd3sScK4hkjooXWV1ipKqiau2RPmBTn8sKXmZ
	 t32Oym7eUWmF4Azm/lj6IQ43cBZKQBOvK20IkPNCkDCTBsPLu3HsoGDjRz7e0/V1PMSEm
	 6SlLapKiqF5PDr8Ul5B+yj/EuZVZ+esmywDbWMvL3oZT2mcbJA9vVtwlA+fVcONb7MUAl
	 VUsvvUjd+s2drmUVrNjanCxbFrwLER1kBwXJMPUEOUXLBFgzu3vixoD5pwIfv16sESg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Sc4JG8uc;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B7A606A31C
	for <linux-rt-devel@lists.linux.dev>; Wed, 28 Oct 2026 13:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61B7A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Sc4JG8uc
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-535179e995bso10363351cf.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 28 Oct 2026 06:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793194917; x=1793799717; darn=lists.linux.dev;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1mZLWc84btDXl0MHk8lbS2Z2QDCAWwzGK7CzWjzphtY=;
        b=Sc4JG8ucOBJ1mCkAH1ck4h0+t+zH4qQualKy+x3gYdoTjY0qm+qJwgRvrL6PSauZko
         oQ0InwnuQIx51oRt7AmK26Qv50Ov8TelYivTDK3A3sn01YsrfKKb5dXSKsJb5o0oiieV
         iGrKkm8E80i3HuDC+Sr2F1qku29v9/E0d1s7wmlZTyJEJVO4G3Hu/PdedQnlbr0qdXne
         yyBqfY0hzdAX6pQfiZT7RblHr4t0s8OhUYZlqN55hwAEPUosGCJtsxf7gyjsm1kGg/EA
         ZqQGzwbG3kKBuFD7zZ9t8QC6KO4hSnQyR0Ji2SDEFVP89UUzqVBYDCPAsma/wbh/78Yx
         nzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793194917; x=1793799717;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1mZLWc84btDXl0MHk8lbS2Z2QDCAWwzGK7CzWjzphtY=;
        b=mp2jQlYz8R3XHuRDjfNLvwoI29C9CxGV67AWP+aatINJArOzDZUU1QN6SPc9GCmzz6
         o/1kPJJ1ZE48M4HlbDLqAvUHTgXjBXwG2qLUomkErUzn1vHj9K72WLeRYyhwLWLO1Gwh
         wjUj+bO+7Z9MMKHQnjGLUH5VblfvOW8Gefb/t4WtfJqSC/7fWPhqNn81kROvFYdpyR3T
         cttPHRb8MJG/pdgYeGuNJpbsRYXY9IIVWVBOo2MHQ1SwDDQFqXKRx6NkVguugWMIc5J/
         kIlkgjGnpbi1RHiShZQDKgRWBjtj0jjLUo1caFpSjfE3p98XMANsteeVkJiJ0KXpTNWi
         pV2A==
X-Forwarded-Encrypted: i=1; AKwUvByk2atH+h/7Shg4c2yy2+aEobCaP8G0rKwNSpChaN4sZOS2GyKr5rJdMV8zrolBpJh60UQvdNEc664t2E5YDQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJEj8/T1EubIXOzQrMGHt/Je/r4vqk/AvcxNT7FInS1UXVP61Zi
	4zIdakr1Q4PO8T7ELBj5QjXcTSWud+MBB2cmgu8gG3OZWNeSTOta2J0SlBx7pM1ssaI=
X-Gm-Gg: AYBFou1Lu/4otsrUl3nchID+GgoFcc68jZfZMTDuOSQrdw5KcllY7vSmzM7dZ1dwKAp
	TL7+T5g6U5k101NcNSvj/VWet6GBjS3qTZeNiXxYWdoG5XVsnnvK7+vU+F1ZlXHCKrDulbhKLTT
	j9617iGcWMCcFigbVh5zC1cM8hUxzLINtFKkMtvX8L3SloMnyKUxdtnzdKVBMlc3hm/FikEOHnz
	laSaglVqOAN8Hp3ZPEwuHP9NgkOmFV7TOEx57ZDRw5tMgwacmi+L8znjnh7/S08CJNozJvwMvvu
	/tzoJq2WOsEtb/nFxewabgiZvL7N7cnjnSmW3NQc/z3RbdrTIXsm3OwPtC8CRPuk74zF+2PDUbB
	5htc3ojST9uy6+T1LA7Y4H2ZFe5//74xqiZrXWr+ZnUv8nzuO+L2nK3IQkDl5nf+Aq7Fm3zWysX
	JZ1+tNDKLGgHdV3NOfcQqp3Qbc2CRpXWWO1b/XS6u3AyGYWkypuT7LVmJ2MELexYgD6FhGc08/q
	kzMra1wq2Hm5R0gk5dcevYuU6lrWkrvhvnmua8l5wA9Ago/kiRMZtJgfxD9RTqW+w3DNyahhsLH
	EeWF9KowFrmuLoAf643PF6KCveQVEUbfTQqxDjg3DFEwlbuqC9KzIAQFuAtYSIhCD1Nha/qMcZ0
	T
X-Received: by 2002:ac8:59cd:0:b0:535:52c:a2d6 with SMTP id d75a77b69052e-53fc919dd94mr39416861cf.3.1793194917292;
        Wed, 28 Oct 2026 06:41:57 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c96375sm132097726d6.33.2026.10.28.06.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 06:41:56 -0700 (PDT)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 0/8] mm: fix allocator races with memory hotplug
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, kernel-team@meta.com, 
 akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com, 
 shakeel.butt@linux.dev, rostedt@goodmis.org, mhiramat@kernel.org, 
 mathieu.desnoyers@efficios.com, muchun.song@linux.dev, osalvador@suse.de, 
 ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
 surenb@google.com, brendan.jackman@linux.dev, hannes@cmpxchg.org, 
 ziy@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org, 
 mgorman@techsingularity.net, anshuman.khandual@arm.com, 
 Bessel.Wang@huawei.com, jiang.liu@huawei.com
In-Reply-To: <5e980194-d892-4b68-80fe-612c910c29d7@kernel.org>
References: <20261021023940.1940971-1-gourry@gourry.net>
 <5e980194-d892-4b68-80fe-612c910c29d7@kernel.org>
Date: Wed, 28 Oct 2026 09:41:55 -0400
Message-Id: <179319491540.2032926.7199366288730313291.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-28 09:37 +0100, David Hildenbrand (Arm) wrote:
> On 10/21/26 04:39, Gregory Price (Meta) wrote:
> > Eight fixes for allocator paths that can act on state another CPU is
> > updating: zonelists rebuilt by memory hotplug, and the pagesets of a
> > zone that offlining empties.
> > 
> > I've packaged these together because they're all related to hotplug.
> > 
> > *** Backport note - Patches 5-7 build on patch 1: without it, their
> >     retry is compiled out when CONFIG_MEMORY_HOTREMOVE=n.
> > 
> > Most of these race conditions stem from zonelists being re-ordered
> > in-place at runtime during hotplug.  The result is a mixture of failed
> > allocations, NULL dereferences, incorrect placement (GFP_KERNEL in
> > ZONE_MOVABLE), node misplacement, or incorrectly allowing hugetlb /
> > contig allocations on a node/zone otherwise not eligible.
> > 
> > Most of these are incredibly narrow race conditions, but since the most
> > likely impacted machines are VMs with memory hotplug, the narrow
> > condition can more easily occur when a vCPU takes a long interrupt / VM
> > exit of some kind.  I've made all of these race conditions
> > deterministics with a kprobe reproduction module described below.
> 
> What's the status of this? "memory hotplug" caught my attention, but then then
> is all page_alloc material :)
> 

I have a v4 with the requested tweaks and some performance analysis,
though i think there is some overlap with the other Fixes: series.

I can send it out and if it helps i can pull together a report on
overlap between the different Fixes: series.

~Gregory

-- 
~Gregory

