Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B7F2BD035
	for <linux-rt-devel@lists.linux.dev>; Tue, 24 Jun 2025 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750772915; cv=none; b=ZJeuSQMIlDmby0vVz9UL+4g5ENvNwCb2hetJKGvwR78UGc/tTOeRJLaDGvM1lbk1FKSjosgdTBhQF1IUjvvelTliiGytn7lgRVxCq8HsD/c0OoLO7vtYOKfB7d9nMd5diZaq6LdTXYK65JRhVcUmZwi8sz67kkmwTWHKm6+mSoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750772915; c=relaxed/simple;
	bh=E3V++5MfDVggiII4WpQCK+D0VM0vjMcbOBqOELEWJKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oVoamj2MeiNaJc8BnLP339JeQlJoT9/kJeXMZEPDX/Y4ndZ8QJ+PKyhNpCVlMzJUFp27FeeuEIoZzSyDDvSO7xk4deTyQNMx1fa+XFc1ROaFyXzLVhFIeULCEIdRwbuxkE9U9J+79fAD/oXeBZQRbA4TCqMM355oLKRdK5u8EBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YG/d4P4O; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YG/d4P4O"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-235ef62066eso6836255ad.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 24 Jun 2025 06:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1750772913; x=1751377713; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H99QKyWxgJFviR9gCoeMBJLsUrcpUyL0OAKfLepv64s=;
        b=YG/d4P4OGU70W09H4EkGZWrYxVHqQVdwyf1mi+t2w4fQ0UCrHHm08JF57s8mW1c7Zc
         RLAQYfilaowllRru9YG2yX5aiCOuNXffHaU6ew0G7IIRqK7quF2nykriJit4Q48+yynQ
         xqilkpBfMO08GVsFihqujsBZeoDto2JEzEIXnBUECTHUvZjIZ05EoRexbnJKfxX4jqm7
         eptf4rQLe4QAQu7dQAKiOqHhF06dNAAAe95ckOG9XRRS82/jFF7Gwzj6wj8WiC5iJ4CZ
         86kfpNHFvHUSfY/49IJhhBqLMEqy0hSbNqWpBTrLrn5nHlFYjCjT8QSXu5PqCJZJG9x5
         pJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750772913; x=1751377713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H99QKyWxgJFviR9gCoeMBJLsUrcpUyL0OAKfLepv64s=;
        b=o5Dv3m/rZaPhp8P+haw3jBg/Gm2VXdHUgKIU6LQikqhhQGS/byhOaLJQtqUpFr7aHj
         er4xHeCmTyIPCtZruu3aoNaQ4PYFvx/nXPY5SlukAAE5b7Z1KD6/QrVpfIx/yo/2m5Ym
         Fve4t7M75d8l9zlBXK2LLy+7PDY/0l1QcNc3f4gS3ooZtbmH1o7DoX+khnBkhVi0Ej8K
         FluIJcyL7DiIJ/p+yi9p1PIseIfgUGkmC8Gk0hDxR0aGNhOmdPqsti+B4YqkCIKFq3u8
         uwS7jF4nkIt1+/gPxnA9icPOcvrvjXzOI2xJlogKFsk/PJOfZ/tewZ/0g43QkW3oa8Rc
         YOeg==
X-Forwarded-Encrypted: i=1; AJvYcCVDQxgoF/hZkeNch+4SDQAuLuz3JhnSx2+NM2sbjxR10UkL8alEjtz8vOhrVvCfJ69OvWQoEtthrNfGuFixOw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy20971xlHAq9E34oPAvh+6M+sciszY1YJZajarRPIqtueKuSSF
	374p8DaNj9cyM6ukLJeLF0fGAEX2h6+R0CYvniLKVsT0haNlUhMrmKKk48SYy0dO0qY=
X-Gm-Gg: ASbGncvkt/EG1LOuUeOmk7An33DgmTMP7o8b0I8ijbNUBO0GlNNt3UtlbgdSmzR09F2
	aCyuRDaRO0hLRoA90dpWlx0TjAM3sTwbYCyHBRPX9a0tMJcXnfUNPIz0FDVm8aQV9ZUw0QodGsc
	ZJS5dYEtB7wqXkaGParzxj2trjYLOlkB9YguY9JB2eXWV9QIzl16xIiyBDtKSWHfW0SKgiiOMys
	kH5HRnZc1PvmPyQaIN0PjQQpmk5dKAgAVRbU5iVTwxVg6HVS+eB/P+/4HgveaobJKeDDxgKvVI2
	v9ytjsERvDCZvUJ2V0UXGROxfC4lifyz8jHwgy+t8nWsUkT8M3SfPX4l8sK0CrejuqX+OyN5zch
	XbXwCtzI4w/6G6MctZQ68c8/BzFOryec=
X-Google-Smtp-Source: AGHT+IH3VVcKlPmQAwhvEtRsqViiUOznLNr6sCLhqQcLQB4C7EhcexsF4UBAe4n2C1iZkbDQyg+oRw==
X-Received: by 2002:a17:903:4b30:b0:234:8c3d:2912 with SMTP id d9443c01a7336-237d96b6361mr256983115ad.11.1750772913474;
        Tue, 24 Jun 2025 06:48:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d87391e5sm106566055ad.244.2025.06.24.06.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 06:48:33 -0700 (PDT)
Message-ID: <d135d6cc-5117-4b3a-9abe-2e5fd9e3e490@rivosinc.com>
Date: Tue, 24 Jun 2025 15:48:21 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Enable interrupt during exception handling
To: Nam Cao <namcao@linutronix.de>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
 Alexandre Ghiti <alex@ghiti.fr>, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, linux-rt-devel@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>
References: <mhng-60581B88-6FC7-4349-96B6-730D908ABF4A@palmerdabbelt-mac>
 <alpine.DEB.2.21.2506240303170.61655@angie.orcam.me.uk>
 <19cf2371-7293-4e71-a17d-669db4c8270a@rivosinc.com>
 <20250624131730.XqPd1HUR@linutronix.de>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250624131730.XqPd1HUR@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 24/06/2025 15:17, Nam Cao wrote:
> On Tue, Jun 24, 2025 at 01:37:13PM +0200, Clément Léger wrote:
>> On 24/06/2025 04:09, Maciej W. Rozycki wrote:
>>> On Mon, 23 Jun 2025, Palmer Dabbelt wrote:
>>>> I'm kind of split on a Fixes tag here.  One could argue it's a regression, as
>>>> having interrupts disabled during exceptions is going to cause all sorts of
>>>> performance issues for users.  Seems a bit risk to just backport, though...
>>>>
>>>> That said, if nobody noticed then it's probably a good sign nobody is really
>>>> paying attention and we should just backport it before anyone notices...
>>>
>>>  Oh, someone did notice and it's not only performance, cf. 
>>> <https://lore.kernel.org/r/alpine.DEB.2.21.2501070143250.18889@angie.orcam.me.uk/>.
>>
>> I also had a series which was doing so for misaligned accesses handling,
>> but after discussion, it was not ok to do so.:
>>
>> https://lore.kernel.org/linux-riscv/20250422094419.GC14170@noisy.programming.kicks-ass.net/
> 
> If I understand that right, exceptions from kernel should be treated as
> NMI, so that lockdep can tell us if exception handlers touch locks.
> 
> But (conditionally) enabling interrupts does not lose us that benefit. It
> is still considered NMI by lockdep.
> 
> Unless I miss something, the patch is fine as is.

Hi Nam,

Yeah indeed, providing that all traps handlers really are reentrant, I
think it's fine.

Thanks,

Clément

> 
> Best regards,
> Nam

