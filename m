Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793740266;
	b=u5D77xBLFb5T/vAea97YSyfbzjq7p8va0tBLiF2BHaEADXRn55OngUNCJPfHfiti+YvR
	 DeEZ7/1X4bdnvOhATJPuIkMP7Q2BM9hSaH1p8DvMF7rMS2fJhHdBxvn8mBGZyAhCFO/De
	 s/nrK6i1NY4wAklr8SFXkdHmSSfyRHltpGjuEx/mDUZp5dewANSpD8ju3C926WdhmDrNo
	 oUyw61l/w/ij6R5F9YYiy3SkAY7hi4oUbqTwhdafxVxR4EEImp2ap6ttOkaCDVl+BW/YE
	 SrlVPEKGvo2EfdVGAKaUsKcKhOqpl9M0k1ZQ2NNbdvInRErwzvhQPoXDDcdYGzIw+sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793740266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=Gwb0yhNA8ovJvghC21bfjrqEFSJ/3LvirO9QqnwCwDw=;
	b=PizPNao4oS5W2IKQZqAoGtMNf8kvcXQMuwhDuO+g1CSakSkJnZPtl+U5Xi9/AHvzYd+6
	 I+YUCZU3vYeOoQp7zzeYoryoIn8dUByo+MJsJIgFcktmd0Gh/9Dy03IcFvGBBGlToTCrq
	 c/7Jf1a7GY+tgfw4DRH/wm6fIIWOSoxl8hF+PqLJSbjJ/duikPtxOdM1Z5PY7vlOT2Tuj
	 1gYmqoepgxbWOLKMO+q0nbOOMbnmmqEcWIIU9PTM+cDhop8ffOReZ2wHcxoUWv4GKeNYl
	 kMSkXCGkQBK7I6V6peixO8JlBlLF2tQzL9XK0oeAizoyENWYvEpLveTI65ylHOSnRvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="XMl3Eb/0";
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10D6606D833
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Nov 2026 21:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C10D6606D833
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XMl3Eb/0
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so759414a91.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 03 Nov 2026 13:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793740265; x=1794345065; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gwb0yhNA8ovJvghC21bfjrqEFSJ/3LvirO9QqnwCwDw=;
        b=XMl3Eb/0OarmGfNlJ+YvKbIS4JZ0R5wzRn8a8OEjiBoqN0qva3aSGbPwliYvlXCbrd
         wxmXlI/W/VunxlUH2B0GddDGVQ9P+vMGci72zUPoWHD0c+IxaFAwNZpRGdQjUYiMB7w6
         TBWcem39RkVzrxzmOYKzkIdLOEhKAg19paCeKSW6AlnjZ6EvDV9ReGq32nwb0S/oPbrq
         agPt2m7FJ4GupdtgfKppX/KdZqjKS8ZOg0WsCfMU+U1ULFkQdiJtoyoJ8nFL41trJYwV
         sr2gJPFSKShRzcVNZDCR4rK5XJD0aZPXSM/c+48bUqxduBw/hTH3YiYPAKPt3Wk0oRYl
         jQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793740265; x=1794345065;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gwb0yhNA8ovJvghC21bfjrqEFSJ/3LvirO9QqnwCwDw=;
        b=h73SbVEJnTPNH428IAZmjTDbeA+0kguoXze4fK5mEToBImp4xpP/mT717Dx+4scq4w
         0o2OTDVefVYy/G+AqOoQBmxNliXBwOBpkO7Fsi1ZQPMyhHRROWt0JJicWx2f5mRbT58n
         Wp34LiaqitmN2p53HsFoSlpukvbMSWS22KhYYxMjoy0zdO9ACvA9ECxnbHs/5XSBG3Wx
         xXPtuSShsW07E0dFDnVhMZ2gC2Ozt13pGmu+Pwoz7LKl0EieUP+d/0ZxcEYdn5dol8Us
         cxjeFJqgzZ0446VQiyauRmvBmix4JBKtstUeu7xsc5/D5PY27b0W6+6uA+IGM6w+LMQ4
         4jOg==
X-Forwarded-Encrypted: i=1; AKwUvByOOxBS1DlCNYh1sQyiQZo6Z57tfuEwwhkdkpw+9Ykei9hFgRC9vnvcBvKSPqR8zkQDzkhJPmtcEA/aMs2dHw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+K6u5bvXuqIejcKWt8pvKYkHZCBQ2RzkWRmJ7bpdHAOh3tg0Wm
	bJS2SSq+93sT2gyRhwP0irPeG0jYgzyqf/bF7KXuIejd9ciMSfMYkl3bo52U3Q==
X-Gm-Gg: AYBFou0ggruY7f47xaT0dLIpGEe4lyM/73zquHZIO1q8z5ZQTWTnw5llZotqOVV1Cu7
	6STichU3nLd64oPSTYmYdN/zjzOJRKdQwf+gAScM4HdQKYQTqpAXpXRy5VuEutEDyCHmGaBSoxx
	YiJ97g7Gk1NwdRwkPFwTUssvsiNs6pS6x7klVvRbifiwk9+jb8q3qepM+lY+XwQD/R/xD4PaN5Q
	03uor7Xd45WEjn+Oq8kH7SShv9c1FR7r7RgZXM0Qo7VTltWfJqOcSMQ0nuZEghhe8EzFFlkzsLi
	xyQKYORa6xnSQSgRtHOLDE8FlBKZzL1ZT1xsHcGnPHbWfuiJ46F0DRYt6+t9OspU9FuxbgwDomi
	GRZQdKyXoPk3GXjI4v6p/LdrrL5JVPcEAma5zxnUcDVu1C4M68mor4QpVYCphL2dnBWq6UiFc+p
	c3xwpe2LS4MBsbCY59xpxkpnyTnTmCzGn4uHVYAnih8KcwZ/tY7IA0zpZbuiDgGDgdtB5i0EhAx
	P2cHdHkNGyFOjkGrG9iJhd+ouiJbKC0e73+WxzsdSgAEKoAAosghoLJxP5g84Dq0PhidXwSBMC7
	Jx2PWXjQG6CoYtGsWanNNj69tVntrvokeSECdZza6DHpya0T7IuVjcghCekwhvbXjDPFfeXWj06
	BCtmzlAfpZaUpWQao5MRkfcxgKPDkanxaTA==
X-Received: by 2002:a17:90b:5624:b0:3ab:d26b:c2df with SMTP id 98e67ed59e1d1-3ae89758b67mr7781961a91.27.1793740264860;
        Tue, 03 Nov 2026 13:11:04 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944ee6easm336849a91.2.2026.11.03.13.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 13:11:04 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 21:11:03 +0000
Message-Id: <DMLVUTB5J1RJ.2QKOUW6UB04ZM@gmail.com>
Cc: "Johannes Weiner" <hannes@cmpxchg.org>, "Michal Hocko"
 <mhocko@kernel.org>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Shakeel
 Butt" <shakeel.butt@linux.dev>, "Muchun Song" <muchun.song@linux.dev>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Hao Li" <hao.li@linux.dev>, "Christoph Lameter"
 <cl@gentwo.org>, "David Rientjes" <rientjes@google.com>, "Sebastian Andrzej
 Siewior" <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>,
 "Steven Rostedt" <rostedt@goodmis.org>, <kernel-team@meta.com>,
 <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>, "Sashiko"
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH for-next-fixes v2 4/5] mm/slab: fix a deadlock in
 memcg_alloc_abort_single()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Harry Yoo" <harry@kernel.org>
In-Reply-To: <auo5G__ac1qA9JRs@thinkstation>
References: <20261103-kmalloc-nolock-fixes-v2-0-19167cfe4779@kernel.org> <20261103-kmalloc-nolock-fixes-v2-4-19167cfe4779@kernel.org> <DMLSN9VHK0P3.2A97046A4YXGY@gmail.com> <auo5G__ac1qA9JRs@thinkstation>
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

On Tue, Nov 03, 2026 at 12:21 PM Harry Yoo <harry@kernel.org> wrote:
> While this is technically true, this relies too much on the current
> implementation details and makes the code hard to follow.

Fair enough. I don't insist.

> Patch 2 is an independent bugfix as-is already. We should really stop
> open-coding slab_free_hook(). That ended up missing init_on_free handing.

Right. No objection to patch 2.
With patches 2 and 3 the !allow_spin side of memcg_alloc_abort_single()
is an open coded kfree_nolock():

  kfree_nolock()                    memcg_alloc_abort_single(!allow_spin)
  --------------------------------  -------------------------------------
  memcg_slab_free_hook()            -
  alloc_tagging_slab_free_hook()    alloc_tagging_slab_free_hook()
  slab_free_hook(!allow_spin)       slab_free_hook(!allow_spin)
  free_to_pcs()                     -
  defer_free()                      defer_free()

I don't insist on kfree_nolock() there,
but can we try free_to_pcs() before defer_free() ?
Like:

	if (likely(allow_spin))
		__slab_free(s, slab, object, object, 1, _RET_IP_);
	else if (!can_free_to_pcs(slab) || !free_to_pcs(s, object, false))
		defer_free(s, object);
