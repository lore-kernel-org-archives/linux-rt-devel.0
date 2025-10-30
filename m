Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959311D6193
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Oct 2025 00:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783990; cv=none; b=L/QriiuBWNAX4KumIMV3AWenLYThrLmuX864G4ZTrvgO2Z5zK+Y1X2CzSOn/vexH/GC/3XQUZ7Jfk8feA/z2EMvLX9gjIFp8357pdG7xq9wXBYfnaciI7sRUOV8eSRrN6IiumyRQb3Ds/HK6WgCNOxrSoIGvyf1g7qRv+euv4TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783990; c=relaxed/simple;
	bh=zPUsAbPnavZ4td1AfI8HdK6vuKE/XGdHzWIQ9Lztg84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dw81g/bs3CYVsEsbkAWsFi2i0uQy9YXF/mrB7Ywb54bHafHkL3kIgrn5s9MQU2OzbrOrrgvtL5ZN1SrwdxPbWOOpHaONyu+znK/eDbCFxCJIxucMaYDHXkm6AzRIvgjPAGwFyVftaqGs880Zcl5PwktoDDV7KOYbWlnHxKw2RGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZynTCd/r; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZynTCd/r"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429b895458cso8356f8f.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 29 Oct 2025 17:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761783987; x=1762388787; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPUsAbPnavZ4td1AfI8HdK6vuKE/XGdHzWIQ9Lztg84=;
        b=ZynTCd/rxpj0xzTfi0QPvv6HpR8afUQP0ZyCLkErqHAaPcp63rBhXsC8DrgeACbdr/
         Oufo4aIeIna9DJsmCn3RMWWCuqZUc3UNaVvV7xQ1Wpodwu03TXK72WXxErzpDmorS2T2
         mPWPhfe/WhvWGbwtjtFFv+e8rsw4XvakM//dZkjicDavbkJnuF1htc3BlUBVfEUHO20R
         0HJvR6mP1flh6VVxD2bpm9/1KW67rXEhtbZ2A0znK2zTBMiTYC2xJrVVOGTjfmt+4Y8P
         RtuKtdHWoqnViGQSw3b4RB/qFvD+FEvmW0swEb68w4D3wXK4tU83iy4CQUL9dE/OZFP8
         M/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783987; x=1762388787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zPUsAbPnavZ4td1AfI8HdK6vuKE/XGdHzWIQ9Lztg84=;
        b=sj1Cy4b9bRit2lfPOXVBUzeqs8QAdzdSP2+o6zK/CLmoIH3YxAcFsHZTE76U+1DGMZ
         lWzmSw5EhjPumNGhdkXEu+Kh5M9QbgQK7McX6fG9EDhN9LdJpo9iqEp+fZUe6YkO0LGi
         kbt+Qkht5yKdr/zuJjqOe8uteRdSemZG1TdxhhjZDe9+/pvRMsp4sm9s+P2PVM8HpYfY
         DmI+R9aWdaOr9wdvegHQRKqI70h+WFvCOhhojDQDur2ePTYL92ekr7kwXSfeR8FrGe/0
         Yj2HVBvTkhF05Zdh1rlXEz0YU7rpkoLfzSTDos2cRlmADcmuFyTjyno1wxfMWbGN4SGc
         HQig==
X-Forwarded-Encrypted: i=1; AJvYcCWSoPIg6bXu7ClwXD7PYymp8QHewQgI87jqYcpCowMi+V+4SG2IiOPss0j4YAYNzUCy1oqf4VeMaaEEXPLaYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtaZfDCdCDFtNs8ZzDPu483Gkjth1XzaLcVgX3fw5tDMbo/9gr
	4nYS/M0a3wV7w2atINo3nnk3PSEsU7PYAYjmNhlERRvxPq/QOPY+sp883/nxnQROz2C7G5LAPPV
	Z8obG+eaIjbTfUBgCFccgVoqidTJM0jE=
X-Gm-Gg: ASbGncvzubGM6NFKzs3M8+6YkWgXDXEgey3eyuM5KzbSArRmHOtoGMge1JGxCcIuCr8
	95E0ed4N3x6u+cz/QInpIHbKDI2gY0kL3+xjKTbOfAk7TRdFHn9kfw0f2L6tV6tHhSYfQQIk52+
	6cw2iurbzcWB4+KLx4WvmnQERthTE7oZoktN3Y8kmZ+MPSeG+6vxXNo5vT6NE6BE9dbeU+d4uxP
	VSQeszFGKqS57gruqD7usUox3QQdnqktFdLyZEeNO4smspgOFmAiRdzE/4ga3C7fKh/PaT2sMgO
	JDIltj6mU8TeaCNzz3PPoT36w1rb8CJr0IjqLug=
X-Google-Smtp-Source: AGHT+IGkQ/Jwdz0hen+IZZordaBwb0FnIsLHdm9Vab1VmHts7m1t5JFOOcsAaPj7+O5XwKDwKAOewvz8pmWBLAdPVtg=
X-Received: by 2002:a5d:5f90:0:b0:3e8:f67:894a with SMTP id
 ffacd0b85a97d-429aef715f6mr5362079f8f.5.1761783986804; Wed, 29 Oct 2025
 17:26:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
 <20251023-sheaves-for-all-v1-11-6ffa2c9941c0@suse.cz> <CAADnVQKBPF8g3JgbCrcGFx35Bujmta2vnJGM9pgpcLq1-wqLHg@mail.gmail.com>
 <df8b155e-388d-4c62-8643-289052f2fc5e@suse.cz>
In-Reply-To: <df8b155e-388d-4c62-8643-289052f2fc5e@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Oct 2025 17:26:15 -0700
X-Gm-Features: AWmQ_blIRE7qylf1r00bSF1LUzzYB2Ikdwsc9BuLrth2mRvMZNLO8ddWxSZ_asA
Message-ID: <CAADnVQ+TQZXhOhfG27kKdX8QUmua6AAqX81CnkS2W=4TANPUiA@mail.gmail.com>
Subject: Re: [PATCH RFC 11/19] slab: remove SLUB_CPU_PARTIAL
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 3:31=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> > but... since AI didn't find any bugs here, I must be wrong :)
> It's tricky. I think we could add a "bool was_partial =3D=3D (prior !=3D =
NULL)" or
> something to make it more obvious, that one is rather cryptic.

That would help. prior and !prior are hard to think about.
Your explanation makes sense. Thanks
