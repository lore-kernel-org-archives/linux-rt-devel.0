Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646567;
	b=gJHf+iN8+CRybImVW1H03NWvYaWJH9xJkVGPkaE+HZZ1AwxBTpaHhOBQc1TX46smmoFH
	 5RbEXK/JyjuRGzi6RTwmNa3ZvKG0QHTjb+b6YXXVolhcJhZ+SRSCjPoa7RQWflZEtw6Ir
	 5AmmolvD3O62GhkTypM2cYoMMTQ2bDJy8mDtaMPHdIED/LnQupz1ebwkXsUZThObDPh6P
	 oW/IOCrRmNl7GxVfAfp5zzObVPyI7AeWD6MzYoILIWL00OfN6JFZ1dg8boCuGORYuMvHF
	 wrNk/LlAI0uQSS5Yg2awKNRzKg+DBohdf9S+Tl5CEkyDtLtjNsN3YQC9cXVP/XXODgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=wIfAdkxQcsRohaTqE06fnblD43O9O+Djz5eJ6myvDxo=;
	b=YWO9cZgF6AghdevmkXHUpQBG+NL6Bysas4Z8IkWTpgDu6H8XWW5+LDqsjzFE1Hbceb0U
	 Yz8MR4kNqbPx5K4hWT4TUW5sJLPsggxXMSbbZoORGBnChy2+LNfbLBlx7iKi2X7OY3vAY
	 iTjq02ptC9olsP14gbjo0FlKYvN+d27aekTrm0ifDZIZJTiRZHIEsAauqBTbcApWuoW3/
	 +ZhcM9//3zSvuQCJo5EZfHRPRQuHFkf4vUCTvLLYp8vXgkTegTGUz1EXAxd/Ehc7bcqIg
	 zqQE7wz9/UOcAH/XEIT6XJEjruAE/yMCJD+Kqa2l8xE/XkuGvPBUfIWLRtfmSrNo7lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nJUBFNXp;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF88606A321
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 22:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFF88606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nJUBFNXp
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso5572637f8f.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 14:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795646565; x=1796251365; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wIfAdkxQcsRohaTqE06fnblD43O9O+Djz5eJ6myvDxo=;
        b=nJUBFNXpECcBFNC7JcmaGibPq/FlDxghGVKVLVd+fZWWH16JkFjVMEahnfY0yr5LCO
         b5w/AOCPwt2+XR70rP0KHo+OXNGKgKeL08nHSr2qgsowUj3vy6YYX3wUfKXoC2nJ2UCT
         JJ88oS7k5XjbjlIFKG/iohoEXbY36rICWfF2dXgzkL7ML9qFlbkqnM8KlMZgy2FJ4M7d
         Ffzz1qEaKl3KOdQJS0VkWVXhRWOUOiaWcd6OtBV2df5+kphObL9JYWK/fuPoNU71oX+f
         82FojNGLZkjuDakdVEAJghGdxR8rAsQ23t/dSSjGvR78lJWiaZTHJCKwucX95vJE71mr
         Z9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795646565; x=1796251365;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wIfAdkxQcsRohaTqE06fnblD43O9O+Djz5eJ6myvDxo=;
        b=rlZ2L0/9K3R6VQ46q4qRpb87rR1Ex9YzIRKJx/G+2xc78TYbcrpbnMKPHfx0aT+Xgq
         /lqHvWuX9I5pxrDj5ej8X4Cr+a+n6GGL4XM8kzTWT+Bd+s2boHVN9kTC/+cpAhlaaoMh
         2N9NpYMdK8AIYtM+3dvl/TLeP5OrxNbYPjKL592RJdeJPqlr1k8yf3X15fJ0ifKzWfT4
         bbCAadJmjuQq02UHisEfIQWvdwdFUsbI53U8FMMtv9wKL0gqBvQcHg24TmETXHfkTXm3
         4vLUTtMpoNynQpuHC0UWlwbtxySR5CQ1uggHhBE9NB7JRfIkBgcKoXRd/ov3AVbhsKUd
         DLiw==
X-Forwarded-Encrypted: i=1; AL+hErGByYxyYsQDEiFNLzyiqE8A9KCBsQdGaOa79MEcM9i2WCxctLgtU/BmF9AN9uGv42pmeU18EWVLm14Yhf8XMw==@lists.linux.dev
X-Gm-Message-State: APuU4Z88wwJCmiNx9X3k8fXKHsxizi3n6g5pXjLe1f16XCs1W4RS4ZMt
	VgUgu22BpsVhRIBaFQdtmgrUODt4BPOjQrY/Q6aqRzN3ZC+WaMtyYxZ3
X-Gm-Gg: AZFdTZcgU9JPzeWU8AyWipRazL45z3QjOhJusH2MdeBHrask2Qks8XXsF8wFdzPjg98
	rh+X4mQCdfOFyICZYBUC9qrdJXcKFYEOl/QvACBchQoTLuPq+GZjt7xnuHCfH8llQCSOsc+sXlC
	OiwK0jLTyNtrcGhn3DBHC6A/D4iQUiQFfPWdpmKEy37IQVv0dZi+Ccuenx6Lz1YhUguElAoTKcp
	T4JW+WF4zPj5QHC55FuWxAYWVjgsWMKFtDuiUX1Eig29yDppOuJOU9nft9U6W625bnY+zuhdD8N
	J/mpuhWGB7EkpwKRKX0u7d81Ar/F1DlCdZUVHC7rdCuDavlivr9P+SDiY17boWHCky2k1Xtsh9n
	xGNsLSAbuA9RtyiYvrPPNKIZk0GNLl3ht66a7QYC5/iogLLSlajq3B9hRdQ0YBI6OsOmQoz4owj
	IR6+/YbPSxMZSfegZ2ksO5ztg3/kl3F6Z4NkcKvc28TsmPfUAhUf/xjoxy7/rXXFUxZ1yPyHqMw
	TFgw0ji2urWBMxBLeGVvOMrzKoLBHNQswIP/J8l+7GwQrpLYqSQsR0ChVx2n/IGPR3OFIkUtUhf
	RgElOkEtzReEuslhJSH6E59bZg==
X-Received: by 2002:a05:600c:5493:b0:4a2:8c5:5e5 with SMTP id 5b1f17b1804b1-4bb8881c734mr412295055e9.7.1795646565114;
        Wed, 25 Nov 2026 14:42:45 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm544402355e9.5.2026.11.25.14.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 14:42:44 -0800 (PST)
Message-ID: <b7c6eafc-43ef-4434-8423-fc8733911571@gmail.com>
Date: Wed, 25 Nov 2026 23:42:43 +0100
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/rmap: avoid reusing batched TLB flush generations
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Ying Huang <huang.ying.caritas@gmail.com>
Cc: linux-mm@kvack.org, linux-rt-devel@lists.linux.dev,
 linux-riscv@lists.infradead.org, stable@vger.kernel.org,
 Kirk Swidowski <swidowski@google.com>,
 Huang Ying <ying.huang@linux.alibaba.com>
References: <20261125-rmap-v2-1-0ba817662eac@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261125-rmap-v2-1-0ba817662eac@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/26 10:34 AM, David Hildenbrand (Arm) wrote:
> mm->tlb_flush_batched packs a 15-bit pending and a 15-bit flushed
> counter into one atomic_t, and resets both once pending gets large.
> flush_tlb_batched_pending() updates flushed with a cmpxchg() against the
> value it read before flushing.
> 
> If the counters get reset and reach that same value again while
> flush_tlb_mm() is running, the cmpxchg() succeeds and unmaps that
> happened in the meantime are considered flushed. A later zap can then
> skip the flush and leave stale writable TLB entries behind.
> 
> Use two separate counters, never reset pending, and let the flusher
> simply store the pending value it read before flushing. To keep pending
> from wrapping around to flushed, pull flushed to pending - 1 once
> pending is more than INT_MAX ahead.
> 
> Preventing the wrapping is primarily required because
> try_to_unmap_flush() as called from migration and reclaim code does
> *not* go through flush_tlb_batched_pending(), as it does not iterate
> MMs. So if nothing in the MM triggers flush_tlb_batched_pending(), there
> would be a problem.
> 
> As the separate counters are no longer read atomically together, we must
> read "flushed" before "pending" (acquire/release), so a reader can never
> pair a just moved-forward "flushed" value with an older "pending" value.
> 
> We'll leave the barrier() between clearing the PTE and incrementing
> "pending" alone for now: it should be a smp_mb__before_atomic(), but
> existing arch code (x86: inc_mm_tlb_gen(), arm64: dsb(ishst) before the
> TLBI, riscv: fully-ordered xchg() in ptep_get_and_clear()) implies a
> barrier. This should be cleaned up or documented separately.
> 
> As dup_mm() copies the counters using memcpy() while they can get
> updated concurrently, a newly forked child could end up with "flushed"
> being "pending + 1" and we could skip a later flush in the child. In
> theory, this might have been possible before (load tearing), but two
> separate counters make that easier to trigger. So let's just reset them to
> 0 during fork(). Put it into the existing init_tlb_flush_pending() and
> rename the function to make the name better match the wider scope.
> 
> Note: if a flusher stalls between reading "pending" and storing it,
> while "pending" advances by an exact multiple of 2^32, the counters
> could compare equal and we could miss a flush. The same applies to a
> writer that stalls while moving "flushed" forward.
> 
> That is irrelevant in practice: both hold the PTL, so without PREEMPT_RT
> they cannot get preempted, and wrapping within the ~20s soft lockup and
> RCU stall timeouts would require more than 200 million batched unmaps
> per second on a single mm, which is impossible in practice. Even with
> PREEMPT_RT or long vCPU preemption, we would need minutes of unmap and
> refault churn while the stalled task stays off the CPU, which is highly
> unlikely and not a realistic attack vector.
> 
> This effectively adds 4 bytes to mm_struct. However, on common 64-bit
> configs it fits into the existing padding, leaving the size unchanged.
> 
> [ david: use atomic_t instead of atomic64_t, reset counters during fork(),
>          adjust description ]
> 
> Fixes: 5ee2fa2f0636 ("mm/rmap: fix potential batched TLB flush race")
> Cc: stable@vger.kernel.org
> Reported-by: Kirk Swidowski <swidowski@google.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
