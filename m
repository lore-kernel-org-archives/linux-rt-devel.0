Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90715248873
	for <linux-rt-devel@lists.linux.dev>; Wed, 22 Jul 2026 12:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784723635; cv=none; b=KR+JuPpHBRcg1NgtG4INEC03EbyvSh8ArNNxZf03LyQfT8FPLuhUAqxmQut0Q1PaZsM2qX9oKbqQNWeXqWV5OXxIJHcufxyk5bXNJdCJ2P8tOMi0BnM5JB4qpfULOzKcjX1wVXtSx525Tp/t+67xX2Co/IWLa6IL6NDSoWbUgCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784723635; c=relaxed/simple;
	bh=3d36uKCRaS6/IIOjkmtzpGmWZ1IFVmcVE5FcEMMWVfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kv37i8D+aHq+OZnYu5iztIqs2e9NfLK09kUiMFid9aWVvxmsn47R5cX0i1tw+ULtIXtjeoiFgD6Qw/n8qBaDyTaw4ryBrCcj67KROO5wsoUcP5JvSdc8sqwv1pKys5D6IBsF4NDA3lUDUlgElcdJ5raWkUKhCtKEokDDk5lbtJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJ5UHArt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJ5UHArt"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cf50c6f235so46691665ad.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 22 Jul 2026 05:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784723634; x=1785328434; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QxIfKuOVaE3EcHJclM4dn0Mc9MrDfV6Rgh6T8FHUwMI=;
        b=MJ5UHArtr7Dy/CBL5K33goa54yYN5YRcZKDOa/lOC8kv+0JebQlw2C8hGqbRR5nZP2
         dwI7ILlQfUBJWFEVhwG5fgqrORiM191c7avgEBe/cmvP9sGJawDqvl/UuvWOCd1X+G6C
         6O05w8AHy6faRN9TD+QOmjFrFebWybwZhYQk+uSYx/oKk5lPW6K6MKq6NsWu5wh/faYI
         5fhojIpWVGQmkt8TFJ1lqQvurZDG2Ah0UWpJtMqMNWI0hFWEFTn2JcinYw7RHHl38J9J
         1r17fh3PTFlM1e1nLIZdbsaR1eRj4U26yvZ1TPiK4MKCOBHfe2ZBV1mCNu5a0wC4MFi9
         q+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784723634; x=1785328434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QxIfKuOVaE3EcHJclM4dn0Mc9MrDfV6Rgh6T8FHUwMI=;
        b=SqqvfYpFOaUQhlrGcwDQCmxvlkopgkSB3lUVhw2Hjykwbnlr2Y/rj8M2LnfaAy6T+t
         gN/OEGRd8O/GECNePhhWepMCnlVI4RZul7QDZ6BbP8ybpbSKkZR2mxjCsu0ewksXPPmf
         TJpyygxvX/SH6ypHvrtrki0Mdtkntr4uCyDVBqm7xjfxOBo2GKREUEwR2VJ/zFGHn9s9
         0ZelMokZPandFqmozuZDhHxWYpf9vFp/gzJPSIojCsZy4vMWSrPU3y1y3OZ/9AIVmMxe
         9e/SlCm4V08jYHtrSSj7pUHd+8rYqOi94q/WWlchiM2fjQx3+ZSvmB57BYfUPKhKrD7G
         Q4hQ==
X-Forwarded-Encrypted: i=1; AHgh+RptsrajwMceFwUZFtrGcEzbhs2sqHkI1qPPBnlxEA8fXDootP198amf+PxrcUUmYwgdrQ9bzPCkF9OhR+gwjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGvAwQKhdjq7ZYKKQAzEyQi6+2JvqOrRlFn1Yv3agxVosdvSjA
	qhuUBLSbqCZCHVUH1BWb0N1G/5cjPykC8cSFraq5Yl0zjGmXsO01qWra
X-Gm-Gg: AR+sD10ci8fjE2ufxitr6e0QarqBtbvPnUeUtn1oRqcxvRjRj66rbVGfhYXYvEyN5FT
	4tA2yLWvnvL1uwtmo2rgbg0Ps7QgX8jdLSvXI55BgVU+A1ckGlUvgpPyoSlVzs/8XCORLwvpslq
	pBATdonz8d8E4Ipky+zcDTcKqneuNYbAdJsV72+Vjbq1WHFDUzECUWsBPVbkFrG3RWhxGOMYBwE
	lRF98Ox91SDKMUKGK8SrFHzfZum31wsDUy7PYNG1j2xaS35Ygq2OZalaiSBescgs2s0A+NyT7Y0
	+oWM7VH0x8luQeiRR6iP/Wg7rtRWEN+tLLaNUWX5W1asFrAXPEKdofQUncOfaASuhPYGxSWG7Vj
	o9emZ8aEgd+5i6hREo9JGBicFUyN6sfYE5+6IrjtCkrm0KVbFvMcfcO6CcfZiLdN5gSx5wXcbTX
	aZPeWIn++Td/S9eWuJ3oSN
X-Received: by 2002:a17:902:e548:b0:2c8:4c29:afeb with SMTP id d9443c01a7336-2cf348213a8mr249494965ad.8.1784723633958;
        Wed, 22 Jul 2026 05:33:53 -0700 (PDT)
Received: from cyh-System-Product-Name.. ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf96ac33eesm7214735ad.72.2026.07.22.05.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 05:33:53 -0700 (PDT)
From: "Yuhang.chen" <yhchen312@gmail.com>
To: bigeasy@linutronix.de
Cc: anup@brainfault.org,
	atish.patra@linux.dev,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	zhouquan@iscas.ac.cn,
	"Yuhang . chen" <yhchen312@gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Use raw_spinlock for VMID update critical section
Date: Wed, 22 Jul 2026 20:33:50 +0800
Message-Id: <20260722123350.3697232-1-yhchen312@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717065137.FQ5Ax2W-@linutronix.de>
References: <20260717065137.FQ5Ax2W-@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sebastian,

thanks for having a look.

On 2026-07-17 06:51:37 [+0000], Sebastian Andrzej Siewior wrote:
> Here you state _why_ it must not be preempted. What would be the worst
> that could happen.

The worst case is an unbounded hold of vmid_lock that stalls guest entry
system-wide. On rollover the section bumps vmid_version and then broadcasts
a guest-TLB flush via on_each_cpu_mask(..., wait=1) before assigning a
fresh VMID. Under PREEMPT_RT a plain spinlock_t is preemptible, so the
holder could be scheduled out while still waiting for that broadcast flush
to finish and keep vmid_lock held for an unbounded scheduling delay; every
other vCPU reaching the VMID-(re)assignment path on its way into the guest
would then block on the lock. The rollover is otherwise a short critical
section (a version bump plus one IPI), so keeping it non-preemptible with
raw_spinlock_t bounds its hold time.

I'll fold that into the commit log.

> That part starting with "Convert" belongs into into a new line.

Will fix in v2.

I'll send v2 with both changes.

  Yuhang
