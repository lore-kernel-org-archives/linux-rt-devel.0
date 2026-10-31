Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793464292;
	b=fEtRZZ7S1VTUspn4by6mLj+8QulPUSiv5PmtIqmUBC2SeylNP40EXjVkASs6sXi8cCr1
	 6+9yamHEhY5npJf4WD9Delb6u5+9X7Cl+I6Lw459zl4xezPFeM2Ag3OrgWUpomU9QAe2w
	 4QjNmliB+SGpQanzKDTzqERou9Ys0X9xnXqpBXt00EWty+JnAk87DvgIuK6OVXiv0aU2U
	 JQs25kKb1S895e7gVv4zqHoDgymitYRQdBvCHKNakcbX3imeCS1atRjVcOgwHcULYG+kx
	 A/fVfZy2PAhkCvA+vrzSWklqUfw8Y9bi0gL4sY/c750nw1h7QVumtkSqZRgAUc+vmSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793464292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SCL+ExvyxTDNNteFin+VBl38Uc6A50cRx/B+LfB0KAg=;
	b=GgfIrcGTwfcjTFEWSI/tBNLbfKGCOo3m9gZXjzJ0AunU/NvXDEzC3XOxYjTffr4LMZNo
	 bT7wtGOMfjguoHH3a0IFtiWRqUQuRVsffLT99LlNtpPmw7e18lcDZhFJJK7fxXqPV89m/
	 6KIcmHgv/fQ70jVFLfchMOSBd5ndPqjLAGDcLqvZz9V8qf4XVQpOetkBy9R/TIoNG3CBd
	 8uIByY01Gyd6aLyKuQo2VkYJMyz/Fe3szKmbfbgssmFv891qfTKedKW67qdD0jceXCOjK
	 y8RUzoHVoZ6J+o7z4l2HEzEDA0Cf4NkCVUifkiE1toxlhU1d2dYqCqT4L3KGwHe9GnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xcRjzXz3;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA31C606A31C
	for <linux-rt-devel@lists.linux.dev>; Sat, 31 Oct 2026 16:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA31C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xcRjzXz3
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-98c78660542so950237241.1
        for <linux-rt-devel@lists.linux.dev>; Sat, 31 Oct 2026 09:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793464291; x=1794069091; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SCL+ExvyxTDNNteFin+VBl38Uc6A50cRx/B+LfB0KAg=;
        b=xcRjzXz3vK1VEAImzLG78HcDsDTAcVxHJGlMoj8uoQ5WacXAKSnw//lePeNniFj1pb
         kuZm3Y6uLNwS1nb5wyBf8Kp6cfKWOn2mQAoilumt4YTAR322pt8J/s3g4ZyK3C41+8eU
         0UPVLBqb8qG/zekfmNLlGMdStRiccWwnKiT/zDhR3Gl/94DbiLLlbWWHIiBuT7drre3r
         nlQEd9KwSzpICvJ8VndbUOta6DNl0Z3z+hpBgfSSgIJ5MRwr0T6jd5HGcfaqLeCClGDo
         gO/oBLyzOqmv+KahAYhN/Nj/1WLIF2PmV6fTI6XcLx0e0t0BVi62zFElXCzVSEXpg9M3
         uWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793464291; x=1794069091;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SCL+ExvyxTDNNteFin+VBl38Uc6A50cRx/B+LfB0KAg=;
        b=qqLLiTX+eNmnUIH5dKtou0gHDWqVqlAbMaOhL8TlReGLpjm2y22KvEdoP4RASnUl0Z
         eAFP9hVnzhmMvROnM3eAeCuuFE+lsC9vqhJcg/4lmxgO/3YWy+GhvTZd65IjUyGRkEnU
         jcbXiIvnivQOOwIHjyNs+g8tO2V4hH+mi7FRIQbPpJ4GtIOlQ9ACMmr2b5eqqZDPFAyF
         uZkiG8C6YOAzWXH1rSsuuvaeUjwaC8pix56zuG28ubHRm8+/bZbRDavczqZH74yDGGZ3
         82qkSu5LRAxliA/RbX5knhleGmg8a9IJ1btclac25EcA9RO+nCVqe0idxqmL2i9CcTrl
         F3ow==
X-Forwarded-Encrypted: i=1; AKwUvByjUd4yfv4U62YupGS6emDjsQCggQ+g1hdeXAGaobMJK08jBDeFlt0Ut5lGs9D/29YWANLJWbPRYg5w8P/7uA==@lists.linux.dev
X-Gm-Message-State: AFq9FYL1PB5Hg+BSyb2sQZu+rvRJAne/ye/AdYv5wXyXa19ub1VvX8pz
	JCNsSPFgCSVZUfLdictnFMSU1hh1zHg04kdRDKgpda9WTEBifSmba8PUlkGv9Q==
X-Gm-Gg: AYBFou28KqtWCL0OxSEM0t9QlUm8jPWrAZ1VPy0jvjmcR86tCT0y3LBJpVoJqB8S4Pp
	FO4skOq4HTngY/9nEEpISgw/xTtLBy7kBWMMTibrs7k8HNIOqUS9Esif/92kodKYXHf4MVq8tB4
	QWO+x/93juHcdtuDV5MP71WmhD3wFKdkeRF1V5FGN9ZldYl1nBEvudBHW0bYulXSRdVey3xbjjB
	zUqgu8aWknf9TPTyAaDndeJ7GiU0xzupbh1q78pKY4t3bzIrmHUnCmhxXMEdcgvCzfN3I0BFt2t
	R9yCpLNTLwQw3o3XxbDyQx3ftzHWr3aOFdY0l2MTokpsp0cpnpVtoP//hUJM/eQqyJhaO8RdOMi
	GJsGuxxj71NN1N5p6VPf4uzqNs6k4g8munZQoib4IBF8YZc0pSKQEMutDG8B3v43tN1AUTpT0Hc
	HE4rS48d4llWOdUw3BpNQWmQ218A5/pi8rwpqHHKI0Xx8pYlPCsLXiyudj5AoKTPxVOHyZGAGHc
	wlDur68PBxersaDZ3MyfkaIYysTCSfc34PuFUjJTmu0zWHmUqLi9VL/zuBJ/UJOvGF/m9rQNztQ
	YlKi71SyyFqTZ8SqYgb3MzGRMoViZMhdkfuLeRfg7zRluGv4GGVhe5GNyQWISko41CCP/CQCqbW
	eI16DhysZgx5ybIfJxdaoAREVaDHglME2gxl1zJhJUuzUatTHH4yXthVVMErWj4I3VbqP
X-Received: by 2002:a05:6102:3706:b0:7bb:c382:2ff4 with SMTP id ada2fe7eead31-7d0726ca2femr2413661137.20.1793464290850;
        Sat, 31 Oct 2026 09:31:30 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992ee41f108sm7037066241.7.2026.10.31.09.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 09:31:29 -0700 (PDT)
Date: Sat, 31 Oct 2026 12:31:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jingxuan Xie <jingxuanxie@deeproute.ai>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev
Message-ID: <willemdebruijn.kernel.54d115047658@gmail.com>
In-Reply-To: <20261030081704.251652-3-jingxuanxie@deeproute.ai>
References: <20261030081704.251652-1-jingxuanxie@deeproute.ai>
 <20261030081704.251652-3-jingxuanxie@deeproute.ai>
Subject: Re: [RFC net v2 2/2] af_packet: retire TPACKET_V3 blocks without
 waiting for copiers
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jingxuan Xie wrote:
> From: jingxuanxie <jingxuanxie@deeproute.ai>
> 
> TPACKET_V3 waits for a ring-wide read lock while holding the receive
> queue lock before retiring a block. On PREEMPT_RT a preempted copier
> can delay another packet path or the retirement timer until it runs
> again. This was investigated after an approximately 355 ms retirement
> wait in a PREEMPT_RT deployment.
> 
> Keep copy accounting in each block's existing private pgv descriptor.
> Seal a full or expired block and advance to the next block without
> waiting. Retain the original descriptor across copying and release its
> copy reference after all packet data and headers have been written.
> Publish sealed blocks in order when an acquire read observes no copies.
> 
> Publication runs under the existing receive queue lock in packet
> allocation and timer paths. Completion does not reacquire that lock.
> No worker or publication budget is needed. When traffic stops, completed
> blocks may remain unpublished until the next timer callback; this does
> not promise a hard capture delivery deadline. Ring exhaustion can still
> drop capture copies.
> 
> Use each retired block's saved last packet and its own cache-flush range,
> and exclude sealed blocks from allocation and fanout space checks. Poll
> uses the publication cursor instead of the producer cursor. Widen the
> producer index to cover the same block count as the publication index.
> Allow an exactly fitting record so a maximum-size first record cannot
> cause an empty block to be reopened instead of advancing publication.
> 
> Reproduction uses a QEMU ARM64 SMP PREEMPT_RT kernel with validation-only
> instrumentation delaying an outgoing copier after frame reservation.
> The instrumentation is excluded from these patches.
> 
> Fixes: 632ca50f2cbd ("af_packet: TPACKET_V3: replace busy-wait loop")
> Assisted-by: LLM
> Signed-off-by: Jingxuan Xie <jingxuanxie@deeproute.ai>
> ---
>  net/packet/af_packet.c | 140 ++++++++++++++++++++---------------------
>  net/packet/internal.h  |   9 ++-
>  2 files changed, 76 insertions(+), 73 deletions(-)

This is still a very large change across many chunks, for a fairly
small well defined problem.

Let's try to a find a smaller solution to this problem.

For instance, switch to a non-blocking write_trylock for block
retirement. If it fails, it will retry in 8ms.

Or, if spillover to the next block is really needed (explain why),
at least simplify. Do not allow running N blocks ahead.

There are also bugs introduced in this patch, which is to be expected
given its complexity. Instead of focusing on those, let's try to move
to a much simpler fix.
