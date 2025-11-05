Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A8A2D23A8
	for <linux-rt-devel@lists.linux.dev>; Wed,  5 Nov 2025 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762328008; cv=none; b=LG/4Z4f3e69G+ZUoV5KxSfACy9sZkXIo5O/L7zrZtL8I+9zR1ongrqADuVjUiD/ApTkphSYUED30IXZ2860W6svxRvd2LneRedoKVmWXOsydXoXxvO/ViiJ0fRucsymKVpwu+H8aQ80+BixdvI6XYqs4SqUBI+N4bdseamhinSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762328008; c=relaxed/simple;
	bh=DDaCbS5eQ5rAhivigtNpf/DuFwnezvzyln+B6kkKZXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S7QioMVSXfbnDjPTMr9qm/Tlc4hoYino0fSPb9cjblSVr0fHmnH4qiZiLFRemX/8WWbFAcemsK+YefHtULC0gHxBlLBSi1w7U6mK7vvhxLlhI7jN8lCCxlc+UGy+4i9zT9zw7Wkq/WXWxX3yjGIUAZQ7kE7mkwjiWRHazDDI9wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JD1Ws3Co; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JD1Ws3Co"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27c369f8986so65413005ad.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 04 Nov 2025 23:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762328005; x=1762932805; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mgd1RgFz8T9cqpU6ApJmDoOMdsD64BrgKz2Bds3lYc=;
        b=JD1Ws3CoB7JuUCEtSv8XQzZV75DOsd4jQbP58HhhzHFg1zV8Ia1qcsbJUwPb2khH6A
         oCi9lArJIP+50N6d6OR1sm0iTugoyV1OfHf7pXdw/LYnS1kj3i2zIm6zPKvfN3VBlHy0
         lQGDXOpw28a0e3BfrCHzmMT+y6S6Pvutq9/QDJ3uaKRhNGvKGA9hgkJU3SGIY81DxUmC
         qVYApx3/rVzisqIuHZnpqQk7Dc7XJoXGfwzM5V2zi0+ETq6j8steeMlwe97aC3BdUI+4
         AmAFTz6qdbyPuollCuGb4SIEFV8hfJo9p77RrPzzB9y5D/y9z6BQzA9LR6dq/fx0363t
         iJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762328005; x=1762932805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mgd1RgFz8T9cqpU6ApJmDoOMdsD64BrgKz2Bds3lYc=;
        b=u8IeMjhzwmz+jVP6Hp/M8TU+O21Vub+w8+yTUeIuTArV7NZ7PJfxkCUN4Wn7zUZ4z4
         C6acPO88jRXd2WoPExIFjG08q5Do0RN/CLjfwExq+Ri4ru1BmFGcc0RN0Dr9yU+kPfE4
         ZDzncGxEDwEC70Jgfz4sj3i31FPyAcCCsQ7MFWqFgwsXWw+7RFeM3ucNad85vl7OD7pO
         wTRQ6C1HRY9WRQ3XdfPQEULi2nfFHxkOw+RcICHAqWJVE9LBzF3KqsGpjUFdb3SafDY4
         MioBFSQDtSf7TFEzlKNEivC7xt+1ZWcgabc4WXywd3ZWMyQr72usU/NsLNcGKV8BBf+h
         Jl8g==
X-Forwarded-Encrypted: i=1; AJvYcCUA86FkBPue3WSWv4P2/Axc2aVJD1OkCJp2wuZBrwJ9U4Ug+s+olpbMuGnUtnYwtKZZPi6xMMp8px7hpSPzgg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUYi8GXuokqohAVNTPIweCpO1c9SnMHLDhdD88SZNkMgTLW6qH
	luAWlkl9qZzy8SirQmTlYZ0q1EnM+jNoAGIBC7Zfo1ezKZf/EannFbeM
X-Gm-Gg: ASbGnctzbt7P/xbj2NhCSnjfjXg2uxJQvEApLRiFuXMxHEtbqSoTTfRkpcRD+MUe0ul
	d7DgTYZQeXkrmDR4pfvTq6LwAq7VJffHh+rPPx80yhesXfisdVyoxFJzoA2LW9tO1iitIcqCC9V
	R9fZOCBcW/V7oGK4M4fR2Ip2MKMLAQKKJxY0UrtaMn+rZU1/rAsZelRgfSx6CKkdhzWQl+Nr3eD
	/Q4cZkKg22gb7LMPpP3u4Iw+DZlJt/g2H1tJuOrEUaQ6FzajkKR3es69zIa0m9AUFCbbwI5DvAR
	ZmZT1vXl7uKCs65HCV2MNmkQa9B0laoHwpBsP5DsJV+KUpSmDX3ZdX8iVCoKMB7qUy58rU2FXsI
	4GiQuupNhZnBEAijrzQv1IavlQ+CV/Ky6ArmuHEE2Vft0aQyKEhVPnbKd3KUL0u8+3wO3Z1vJ8V
	J9scUtZhR3EgK9t63gNm3fmty23A77GddlY4/zWVswKxfOHg==
X-Google-Smtp-Source: AGHT+IFubJwKuqWd8pVU5sU0Dqp6g9b5LXMrACB9qO8Ucy5yzYtRavb/690KX+eucTG0f1YcnGaOIA==
X-Received: by 2002:a17:903:2381:b0:295:8c51:6505 with SMTP id d9443c01a7336-2962ad95597mr33842095ad.33.1762328005013;
        Tue, 04 Nov 2025 23:33:25 -0800 (PST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998991sm50485145ad.32.2025.11.04.23.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:33:24 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: will@kernel.org,
	bigeasy@linutronix.de
Cc: ardb@kernel.org,
	catalin.marinas@arm.com,
	clrkwllms@kernel.org,
	leitao@debian.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	mark.rutland@arm.com,
	rostedt@goodmis.org,
	ryotkkr98@gmail.com
Subject: Re: [PATCH] arm64: use SOFTIRQ_ON_OWN_STACK for enabling softirq stack
Date: Wed,  5 Nov 2025 16:33:20 +0900
Message-Id: <20251105073320.208335-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aQoGdVYOddu9bxLg@willie-the-truck>
References: <aQoGdVYOddu9bxLg@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

On Tue, 4 Nov 2025 13:58:13 +0000, Will Deacon wrote:
>On Mon, Oct 13, 2025 at 01:35:08AM +0000, Ryo Takakura wrote:
>> For those architectures with HAVE_SOFTIRQ_ON_OWN_STACK use
>> their dedicated softirq stack when !PREEMPT_RT. This condition
>> is ensured by SOFTIRQ_ON_OWN_STACK.
>> 
>> Let arm64 use SOFTIRQ_ON_OWN_STACK as well to select its
>> usage of the stack.
>> 
>> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
>> ---
>>  arch/arm64/kernel/irq.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
>> index c0065a1d77cf..15dedb385b9e 100644
>> --- a/arch/arm64/kernel/irq.c
>> +++ b/arch/arm64/kernel/irq.c
>> @@ -62,7 +62,7 @@ static void __init init_irq_stacks(void)
>>  	}
>>  }
>>  
>> -#ifndef CONFIG_PREEMPT_RT
>> +#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
>>  static void ____do_softirq(struct pt_regs *regs)
>>  {
>>  	__do_softirq();
>
>Acked-by: Will Deacon <will@kernel.org>

Thanks Sebastian and Will for checking!
I'll shortly send v2 with the tags.

Sincerely,
Ryo Takakura

>Will
