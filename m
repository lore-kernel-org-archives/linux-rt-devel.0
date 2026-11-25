Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593065;
	b=A4plKLyX4FIx0/59burhz4y9v0yqT0Aqw4GVBviUa1SaRXEJ4fe3eeMlAo3YCvquiYjl
	 q4t5IW5LGXyd6C+dyxMrMDnbfYuulReCwJ2hKjzW7qR23UA1Yd94a/1Gf60oqdkQZqp4t
	 XTT+xO6RWBpcjpobJ8ZqHJAOfp03y065xjYdYFVI0Sfev0tG4W09KU8II+e1ePVZRyxsJ
	 OxpsOTyz3eHsE0AODcnEHYq6+8MeKD+9ZU8xdnx6AeHdoJrLj0ZKKjhXJdvvi2CJ8preX
	 BFV1BJ4jQpDjjgxShDmh6NCemNelAXpUM0jkxhbyK2PicNKG9iZ4IhLpFuTzU5LUHGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CvAjV0S+oO0YGxdmFbKoXiKIWCesLPGwRDNvZl4jprQ=;
	b=BEZ9qd84AYCSmSpGfPQGc9lBcZtFcH2GaLzQLHYkHMq9KrtoSk7XAYvtnAR4cwNDz9Y9
	 xg+hzuS7ZjgHNBTYQ4fAMNzDW+DnPnPamWMbyHyqy7H1wi3OjEduUMPdS510a7a4PWj4n
	 4+H1XbzFiKhNorjwM3SEvA2mqJY5vowmZ7ncQqCCrCCrxryNembaTsdetiQ4AKzRQOXlk
	 LbG2MpZ1Bc/DXRak8bJ2CAoXAQ/CSmP0UEDfvxvZfpX5Nwizfkaj3EHpcCIL2pZw2ACNm
	 YIieiuynvZK40TJAkdyiOq/1sHeCOs2RLpS7NdbbHFMCj1wGKUp1AJZteLKH01+57vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hOJVYt5B;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F17B606A334
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 07:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F17B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hOJVYt5B
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-3b14c80b210so1225409a91.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 24 Nov 2026 23:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795593065; x=1796197865; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CvAjV0S+oO0YGxdmFbKoXiKIWCesLPGwRDNvZl4jprQ=;
        b=hOJVYt5B3hekzNpSGkhhQls2XsbHjUV9P3zvLw5ldn7nxtGJNSrYqiuDcEyMuCUI19
         XlOywXYqHRk0I23qxoVt89FocpbqoikaXgoZflxUywl3ghlsQK+k6HzDMrmYO+ZvfzSR
         HphCfVSXgJpTk7KRvlt3U06L9Apmu1ODVyJVpfZ2g2rmAcE62Hr31w+XDOukjMXSv56A
         dfoFSZmUV3Ws1F1E+9xlUjHnycnOsTQXP9uBYdinhaFJWAjCLikP/niIG7leSR/1/pQw
         JYgSVlP9SwNfk68qsHld2Km2uD3QEqyb59U0OPGYJpP0n4G2e57vd4I4GL7VqiuqZM1Y
         QfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795593065; x=1796197865;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CvAjV0S+oO0YGxdmFbKoXiKIWCesLPGwRDNvZl4jprQ=;
        b=nwvaQtnKT7OwBA8Sp46d1raGcS12DREDV/qEETpen13OP9KhE/SWrYIzQJM1u8I6no
         Luz66WZVMTNYPRygMw0dQ0wkEQJv2IMKKq1BCD/AoCzP8USkKS/wM7ej6rN3O9CeccTF
         mwg7vPuAuHzJSZM0ziVLzgrffahpHRcceiaAqjVSfIiXWxqb4NizjHOtD30qSBwmwyNs
         dgZnwLBM0b17D/RnzYtTGzcbJS8PaJTlujD+gsh+UDWX08xjtrnBNqhnkLybeewBef7G
         Nw1T/kTpl1GVrF/hNgyq3cnwBwAIR8HmiKicj0kQt2+PoJlBSa4UNo2VqDIFZXgB0FJO
         9xeQ==
X-Forwarded-Encrypted: i=1; AL+hErHUX1h29hqLtUQTCYXMd7zYlWUNF2jlGibBC4e2H1a4cN7zWC6wnPHSFGK4zzfx2tsL79FNcKM/RA70vrEUvQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/C3/KlcoB2aO9DHYRULCtMtxWv1gJTkhd9lZP+T4P46W7YZrN5
	p9Hwpa9Ts6Nd3s72dY4+fJHDhkQ0xp4ohs0/pfj7GA7V/3w3j7F1ZOl5
X-Gm-Gg: AZFdTZca20PttA0NNbUknvTrpI2Y+NkAOm66PGE7YodwV8tX1bX+G/aaOkTeNED5n7x
	k7Q4WUSd8nkE8llervG5KRGe3edYFO5qyHc9Jck7T9au/1e4beQL3+npiOn1UXloB+4lJlMfHdp
	hVLqfepVOwoVgC7p0Unktdr85xcu1zJJl06taku7Stn5j+N5BoKqQtHoT1csd263Uc1u4Ybxj1f
	lDXvg2lmQOkiWKnFvcn6RXLgPZ9pKfq5z/8jHdt8QHogKkf8P75iSAJOIMzSpBDyymU3oA2UOUG
	eR6sYgHhsGxukN5WfeRUpx19ffZDc1NZb1oEGW7cxAfGNi+dplPbFC4ZwveKWsbbV/UUSEbqydq
	f2jd1jMx51Cfs9nZHz/MPWLckV/Q3X65nnVJzuXdsUGCmc1hxU4bNFUcy37LvMV0MwbwrO/YJ/h
	AlFBXZfR/6xz3P5VOSyxiZL+rjR4GDPNboZqv7Z8dse/JOpFCAtldQl/fyrh9k1USaCTxHVip8l
	TxKm1JpGCNE3DhhEX/doHpMVITvcC14eO3LrEgxUF1ANEKFhH9c6RCEcbJ3Bvh97HpeFXyTTQib
	6/ph5WYQjLWtgfw05wPAkKByRg==
X-Received: by 2002:a17:90b:57c4:b0:3b0:9cc6:62ba with SMTP id 98e67ed59e1d1-3b41caead33mr14614340a91.38.1795593064735;
        Tue, 24 Nov 2026 23:51:04 -0800 (PST)
Received: from nixos ([2409:8a28:ae4:7f20:3645:b698:a929:4bcd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b7c6513sm12341521a91.4.2026.11.24.23.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:51:04 -0800 (PST)
From: Zixin Wang <w1355457260@gmail.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Zixin Wang <w1355457260@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	linux-doc@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	corbet@lwn.net,
	wagi@monom.org,
	atomlin@atomlin.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] Documentation: real-time: Add boot parameters and task isolation section
Date: Wed, 25 Nov 2026 07:49:43 +0000
Message-ID: <20261125075037.33630-1-w1355457260@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <awXN9RY3x5xEGFe4@lx-t490>
References: <20261124163202.56921-1-w1355457260@gmail.com> <awXN9RY3x5xEGFe4@lx-t490>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ahmed,

Thanks for the review and for pointing out the scope issue.  I have sent v6,
which moves the runtime tuning material out of kernel-configuration.rst into
a new Documentation/core-api/real-time/runtime-tuning.rst, and keeps the
configuration guide focused on Kconfig options.

The existing CONFIG_* section headings and anchors in kernel-configuration.rst
are unchanged, so the documentation links generated by kconfig-checker remain
valid.  I ran the preempt_rt rules from your v1 checker (reconstructed in the
7.3.5 tree, since the tool is not merged there): all 12 generated
documentation URLs resolve to anchors in the built HTML.

The C-state, EFI runtime, CPU isolation, RCU offload, and interrupt affinity
content from v5 is now in the runtime tuning guide, and the configuration
guide links to the relevant sections.

Thanks,
Zixin
