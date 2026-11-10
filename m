Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331042;
	b=1CqClGrutdS/Wm/eRF8T8l+Apk0JcxAHYq3KmbaehOqN5lRzjsqsocH7jo3SUl+UlEwZ
	 8/JFC1VCySDy2JJOEvGBGYVjRtrAclWo2LJpgjl0RDPmS9YYhXZDiAL7cVOFOuMSHp+hz
	 O7RrIA2HI9RRZuOteWX1+xClyy+Mox430RRA8TW+0kU3nF5ShCDhReT/f4oR9EXwO93hy
	 Wk2zMinHgScMjV+T3a6SP9KXcStw5QbYoV+ueO+mSgG6v10EotkSMJYgdL2wc5XsyDqA+
	 lYW7u4eWbja+czPhRUHQ37gHMb9rbCgVwr6HOE4PxwCsRPlbRLfz2ghw4geuyA94IAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331042;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=anu/2F6mroicCWt3l+8C2jxZSamPe+b0q+OPEpgFtcQ=;
	b=1aLN/0FiRl9P3xXcEx8MbuHOlQY0YC03cAfVIuzkhL/n4b84VvJSq5fk0J3hqm7txUfX
	 80G7iQVXyOf5hMM6KSr578eui+QnUOvMnhY+BUMJ0k7uzPW1aF5h122dkcvDL6PrshvAJ
	 s//FRiCMG77TSczhgmx2s9qNwz0iXWNwLIMaBWC7DAy/2eIfQL6+pxGZ5Nt+IokG62N3R
	 Lpmmxnv+GQbKygGxJ9/Qlb2D7LPf8Jiv2BEGcaiMwgWRxZrpk3PdxKcYTkmwd4aNuYKlu
	 VDUs1a89vTqcVeaqnhZfvXLHv68fDdKWEHNPUF1AIRsAUy9/vP2fiPscOE3S+1imD4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MrUx8o4Z;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058C7606A321
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 17:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 058C7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MrUx8o4Z
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eafb65e169so1222995e0c.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 09:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794331041; x=1794935841; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=anu/2F6mroicCWt3l+8C2jxZSamPe+b0q+OPEpgFtcQ=;
        b=MrUx8o4Z68WBm36p/ymmEE3CYdWGwKSVVqEDBCKYMbuGXoZyvbbcHKrTFPTIsxOzy/
         PabdpRPxWs4Jwl52pLJhGUWVexE2c22poGWPm9Bj9XsQthp3uhuvRaLgyZLu7QFohTxC
         1uxAcoOSnUo/8rKv9fuVd9jd4rhi291exhCJ6qp3aHYzMA27OhQ2tY/eDuvDPMH+FF4d
         pWkxcYP0+q/6QCZx/FYpHEUnoeJpugpH7jvlxSiZSnahgyhbcYXWwUqblBF+d7j6s6ai
         8rgr3RxiJqEr0nrjN/I0g07es51ZtjAoNbbM6vhmGdySiRWncSN4PqYivYbqyZlWQBZu
         b7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794331041; x=1794935841;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=anu/2F6mroicCWt3l+8C2jxZSamPe+b0q+OPEpgFtcQ=;
        b=efY+m2KpSHDQawADab1rAp3vq4sbApeX2oWD14D7qyd5NT9UyaGBEFtfGZY9ZbIpPC
         x0DDdaO1ewi94GsztaCPh7kZYLe+VYLsbCF2XpX/Vq3AeLcoAD/2MSGHTloLeiCtcAsp
         vp1r76ano1Hg7v5ERanA69RDg+IL8MGsPkrSnDcjCwdzcCTEXoYpFejO06EMzWhDIMVy
         jHBDRZgBr8kH0CNDOm/kL02aErlfAjRIsYU93HzkCXeGz/VgORKS/QmMNNC4GHF7OGdf
         pvngA0a1t0W8PdeAmY90JtzYQjZZZBNsh8Dvk6ekteODwqqmX2sHre4YJ0mdI2bSXJcK
         V4xA==
X-Forwarded-Encrypted: i=1; AL+hErGMrUsAsgh4i6NoZbYiYEFt6+PUTJUnr4Wd5gPGs7UhO/SgMlLXPdOoosP6nhewiOhCt42SSn2Lx7BSDxBmwQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/cv98PazjIwvbOn4UUtHKzLxf0tpC4bhS9scTm72lGZ3BUlkLY
	+4CBKO9lE3shsbJ0aOzKzDGclY2ZEUUYVzp0rB4tcmANBG9zmhxqBLNC
X-Gm-Gg: AYBFou3dOrwSORH6zPox0gzJA/cMukkj6fMuRjxjU8dSoUbOCeSAwYarNuvFAf9IOS6
	ilj9WZVUjTaxwv7lYPOgxrjf7LP6uYt1QC+1JH7gbDDPd6j+zrUvVu7K/wISSpswRZdrc4wlrRR
	yAY1tm7yYYLkrg+EVi003q/0vQWRSwQCAqlKsGTEpu2py9JwoEjwdR2EhxFPdX7KS5L1LxRijL5
	0/PUSprcN8n1GpYB9TD3mhu2VTOdVzqtQwFE6Gu4SOe0QV9Gxuy4szggcDtzG+6Qf98qUh2ezEG
	ajdH4Pq5m4ujO8j21hOAvfY6buxYPGFm/Z7hR01iffpzYulfQun2IxhylTv7eI/AsgFJVIdhgM5
	52Y56LddEWtJ4fuNMXqELIfQqhtkjNnmz7qH97bVcv0lDJBeFLs/UAcUZyrKls1RhgPj0L1FmRo
	s+lhkPaM0XZ3cBg4H/MbklMbyFQyxx6k1QlTXSWw5y97B3xyHDe1RPzRiWf5q75MmS47wnHBUqN
	Igx83o2A9vfWK0Hx7gJJr6bfhdZ1LkW2VYmAuMTyri0coZqw7sAwpLsfv3aJ9FlB7cg+LCobcpL
	9xYaCmoBln2rqsA5IkUaYcf/XCBd2YgH7MOzpcyA1zejAoio0rFkyFKSDi3dJhbs/hVbo1Or2IL
	eT1ZlLDH+5lSTiHkSjUC2xa/mEdFk353YHEGYgrxg6mI9vXkai+NzpvrpXPhw4c4fkYhwrk4=
X-Received: by 2002:a05:6122:210a:b0:5ea:c722:b3a with SMTP id 71dfb90a1353d-5ee0d0d51d8mr1334938e0c.7.1794331040981;
        Tue, 10 Nov 2026 09:17:20 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c5dace7sm2095563e0c.12.2026.11.10.09.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:17:20 -0800 (PST)
Date: Tue, 10 Nov 2026 12:17:19 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jingxuan Xie <jingxuanxie@deeproute.ai>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 =?UTF-8?B?6Z+p5bCR6Ziz?= <shaoyanghan@deeproute.ai>, 
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
Message-ID: <willemdebruijn.kernel.33a00c75cd53e@gmail.com>
In-Reply-To: <20261110072221.24701-1-jingxuanxie@deeproute.ai>
References: <20261110072221.24701-1-jingxuanxie@deeproute.ai>
Subject: Re: [PATCH net v4] af_packet: avoid waiting for TPACKET_V3 copies at
 retirement
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
> TPACKET_V3 retires a full or expired block while holding
> sk_receive_queue.lock. prb_retire_current_block() takes
> blk_fill_in_prog_lock for write to wait for in-flight skb_copy_bits()
> before publishing the block.
> 
> On PREEMPT_RT a read lock can be held by a task that has been
> preempted or is running on another CPU. The packet path or the
> retirement timer then blocks on the write lock while holding
> sk_receive_queue.lock, and the receive path resumes only after the
> copy completes. This was observed as a receive stall of hundreds of
> milliseconds in a PREEMPT_RT deployment; manual inspection found the
> same unconditional write_lock() in both the full-block and the timer
> retirement paths.
> 
> Try to take the write lock without blocking on PREEMPT_RT. If a copy
> is still in progress, leave the current block and its metadata
> untouched:
> 
> - the retirement timer re-arms itself and retries after the configured
>   interval;
> 
> - packet allocation returns NULL, so tpacket_rcv() drops this capture
>   record and accounts it in tp_drops, while the original packet remains
>   in the network stack;
> 
> - a later packet can retire the block once the copier has finished.
> 
> Do not dispatch the next block while the current block is still open.
> The existing lock order and completion ordering are preserved, and no
> new state or worker is introduced. The trade-off is a higher capture
> drop rate while a copy is in progress; original traffic is unaffected.
> 
> Non-PREEMPT_RT kernels keep the unconditional write_lock(): there
> read_lock() disables preemption, so the writer only waits for the copy
> to finish, not for a scheduled-out task to run again.
> 
> The stall was reproduced on QEMU arm64 SMP PREEMPT_RT by delaying a
> copier after frame reservation: without this change the next sender
> blocks until the copier is released, with this change only that
> capture record is dropped.
> 
> Fixes: 632ca50f2cbd ("af_packet: TPACKET_V3: replace busy-wait loop")
> Signed-off-by: Jingxuan Xie <jingxuanxie@deeproute.ai>

Reviewed-by: Willem de Bruijn <willemb@google.com>
