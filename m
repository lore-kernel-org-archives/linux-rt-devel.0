Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793731213;
	b=b6+FbQo83IpXkM3z150HJIEE3Po974OZdmMkXw4gWbYd3B1X/4qhEdoFIW+yYasJntiY
	 GmOwqCv1pVsaVM9f2GllZkV7/uxUuEJ9kiRlTNSfTMPy/FCtjlvAh7SuiqDMZ3Pddc5zC
	 Zy6LDv/B+LPUDvyV/nM1EJo9+1cvUuhEsn7xiSXt7xAtxGcP9NuZOGCnSofCPtAC6Vese
	 6St5o9S8bH1KAgdwQyhLcd3pySJGNtksdlhEiaOfeslAcoy45zKnhHB1RSgSAyJInzt+X
	 SMjgHJD8gjypHMg6fHRzESttKuUhQd6AoLtKx8PeGb6L+7CJpgYZX2X7/CnaDAyIcuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=1LUYnHObY7Q3ByIwXxp+Nywos3UJ2Q6dqziyGEM81xo=;
	b=fwcUYUpaN9MSnnismT+HQ8laJkLvgD1e86vZqZpj8YzDB7eBZKl4jAQn3ttNYDfjck2I
	 H3PLzarvKhAjbmoQnaLpFTMVovuCL/Ec7rqdML6NP1rz1Qy5/o6JEoRcvMm4PwwZVy96c
	 o+N9mEawaGY+ufRRPS4BTUvosy2W2orWLeOxJG+Mx8fTm7fin86ILD58VRjIexNslT6tC
	 y9SM1mQxHzpN6l+rMumsB9AhTjP6OnBkWrWKoWWFob7vW2NL0ANKg9N77Zhw1DmmCUHZr
	 CgwO/1sXZlVDkwckFO/eRklpkXd/oC9MYUMWyyINWMG2WMOKMgCCufIuqnsPWHyA4Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URmUsCCG;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AA2606A326
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Nov 2026 18:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56AA2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URmUsCCG
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc502d509c0so1853966a12.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 03 Nov 2026 10:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793731213; x=1794336013; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1LUYnHObY7Q3ByIwXxp+Nywos3UJ2Q6dqziyGEM81xo=;
        b=URmUsCCGmOmIQqcnVgxq/fzwtp9dSyzALI7wxrl69nG1zKTJ99haUVxwLQNDu6eQur
         f2Us0mUv8X2AP/sKjUeyWyUz4L6AUWTMYQKXtpmFk1oTwLj8ygq1g/7Q4Im2KfbizSdv
         eI10EakVefEK8VkaRMkkGyNOJX7Y546SATjZV9RVnSsuCRYKl3rdeWQNTf1779BBgRkI
         bSt3jhDeEKxLvx/LtlopNmSluxGHxD+EllDBTZ/TqLQQUJFc9qaZ5qFV4iHGY57sCSvE
         bLenmMS/B6lscGn2UBR6exB4gxnjh8yLpYc2XcXvJl6bPZQf8pLSQE5igi+LYo2/W68G
         hZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793731213; x=1794336013;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1LUYnHObY7Q3ByIwXxp+Nywos3UJ2Q6dqziyGEM81xo=;
        b=IoOoixC70DHZ7UGiyw6wA/9LdsQ/CXSanYkn2GFoIv7gGNiZ3PH5PZUhogVzljnktb
         xq9EWvtwX6Ns4URLadWulb3lH4awdYcScdg5Fs9fKdJ8nn2Ii9GmF+e470khC0MBaKuX
         pyl4c6mPbjhbQXMcoc+kUf0YFv8fXr+DxQ07UBpGiQcz7erXSDKHzZOcngUDOh8botso
         uF5Z+q7k+HbwG9ZSsew30k7ee4jQVcK97hkUtshA5S44XIPN3tN89QEx5UYkdHe8aZY/
         YLRzrdLtIxO4mhqsF4N3Xa7IyhJGfwfOonmyBWWr/+Dl5un+QQV6/o8jvMhW10lM/WOa
         F+Vg==
X-Forwarded-Encrypted: i=1; AKwUvBxu6Cvym9JsimxPMRGS/ZxdcCNLdlQUoqXpDrKU+5Gk596p4JgF7q/OlgCP5Ld5enz4lIbECbzZnjao0WxCmw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/1dRTk2wO/PkaCUtvUToURJ2Bb9A+f11NZQnOmgVdmwmXiPKGI
	zYJSboRzwVvnk4F+7Ui1HDqFzLXpZSYI3lPut0oQR0EaycxqDqtV1SUz
X-Gm-Gg: AYBFou17qZXhRE4RUKaAqsvWg5bFa9Or6X/2C3yBIuRd900LW2djUuGS0rYlBVYKCdS
	zJfOECenoPo5uiUHXOwtU1gYJL5Blu2NcILvht/YIQPNuufu4hVc1A4oCmyfWHMQiGLQOf/ELLR
	A0LO80ZrI5aHO+pV+wk2RUlUjYpJ6hESv41fpVEf8ZAKK5uDPUi9toGvdQeZHbQ8a18P8e2KDmz
	6trPdshDResmC3e8rxFDypdNzEhY9o5LWHaCuIpeSeKtePlUbUGqv48Z20+bgLkvSMykjkyxBhS
	TpXvZ1c/eshkl/v1xxHmHch6W8bLNSbkkshEsgDKJiVttyokOjy+DyQG0QZT4uknDuVo/nJXo6s
	JQbwaLaDYK+g1NEnZbrXwinjF26BmK0ogyUKa+m+sBmUR1NV6KQCG8Qsj3I1+jQzkWwKtHBA50/
	a8ZXBK3Ft+QmzvrGjxYSbw21bU4ftFoSDDp2rGO2dFuQhmpiwiI0GvrRzO+RJg3C9jzYijmE4ll
	8lKkIDwWM54RdmEKVtvAsNT/BXxrctkyABlGdmEXEiK+JnIbgzZIo5FkxTa03uU96q01DlGy+b5
	U4ljYUhZzH6DZQndFNOv2TYR3ccYAyvV7rfl4ykwrGlM0jF8EjBP1TaRvROrbg+f4+lxpyPk4CA
	iWMo0+4s800vI5+GjUBr8NgBJt2zwohZzkw==
X-Received: by 2002:a17:90b:3e83:b0:3ab:2737:3396 with SMTP id 98e67ed59e1d1-3ae89855ccbmr11961848a91.65.1793731212415;
        Tue, 03 Nov 2026 10:40:12 -0800 (PST)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b094d70a60sm58552a91.1.2026.11.03.10.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 10:40:10 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 18:40:09 +0000
Message-Id: <DMLSN9VHK0P3.2A97046A4YXGY@gmail.com>
Cc: <kernel-team@meta.com>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>, "Sashiko"
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH for-next-fixes v2 4/5] mm/slab: fix a deadlock in
 memcg_alloc_abort_single()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Harry Yoo (Meta)" <harry@kernel.org>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Michal Hocko" <mhocko@kernel.org>, "Roman Gushchin"
 <roman.gushchin@linux.dev>, "Shakeel Butt" <shakeel.butt@linux.dev>,
 "Muchun Song" <muchun.song@linux.dev>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Hao
 Li" <hao.li@linux.dev>, "Christoph Lameter" <cl@gentwo.org>, "David
 Rientjes" <rientjes@google.com>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>
In-Reply-To: <20261103-kmalloc-nolock-fixes-v2-4-19167cfe4779@kernel.org>
References: <20261103-kmalloc-nolock-fixes-v2-0-19167cfe4779@kernel.org> <20261103-kmalloc-nolock-fixes-v2-4-19167cfe4779@kernel.org>
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

On Tue, Nov 03, 2026 at 06:47 AM Harry Yoo (Meta) <harry@kernel.org> wrote:
>  	if (likely(size == 1)) {
> -		memcg_alloc_abort_single(s, *p);
> +		bool allow_spin = alloc_flags_allow_spinning(ac->alloc_flags);
> +
> +		memcg_alloc_abort_single(s, *p, allow_spin);
>  		*p = NULL;
>  	} else {
>  		kmem_cache_free_bulk(s, size, p);

can we call kfree_nolock(*p) here when spinning is not allowed ?
Karl's patch did that. You replied that memcg_slab_free_hook() should
not see an object that is not charged:
https://lore.kernel.org/all/asaAwg1KeZoEYd4K@thinkpad/
It's fine. __memcg_slab_free_hook() skips an object with objcg == NULL.
The else branch relies on that. kmem_cache_free_bulk() also gets
the objects that are not charged yet.

> +	if (likely(allow_spin))
>  		__slab_free(s, slab, object, object, 1, _RET_IP_);
> +	else
> +		defer_free(s, object);

That's an irq_work interrupt per failed charge.
kfree_nolock() tries free_to_pcs() first. It calls defer_free() only
when that fails.

Then no need for allow_spin in memcg_alloc_abort_single(),
and the fix doesn't depend on patch 2.

Something like this (compile tested only):

diff --git a/mm/slub.c b/mm/slub.c
index 45e077c..fb92b48 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2551,7 +2551,10 @@ bool memcg_slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
 		return true;

 	if (likely(size == 1)) {
-		memcg_alloc_abort_single(s, *p);
+		if (likely(alloc_flags_allow_spinning(ac->alloc_flags)))
+			memcg_alloc_abort_single(s, *p);
+		else
+			kfree_nolock(*p);
 		*p = NULL;
 	} else {
 		kmem_cache_free_bulk(s, size, p);
