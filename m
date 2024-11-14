Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26231F8F1C;
	Thu, 14 Nov 2024 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731584810; cv=none; b=Pvj8RX6rOK43bQYBR6mC8nx1+g/GcdwgGviDvbVCpyY3fIAnK8eItiIWjIzorHx+D1hGRdCS+pzHLNEltXa8o8vDMRDiLoiNKWE00g8ejCltbOLpuuAaH6E47aQWq07BN6xH3kRR0S8oTUC5S6MBOR+eXqyn7RWkxw6YtHTfmWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731584810; c=relaxed/simple;
	bh=7ZyLogsyw0JvegtvsA9lmpsM17jAsYAfH2uhNPnrrmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDM50P+uFp2sMAcDGzO4udcv/oqNJ6dYoQXlUt9Uqk07KoZiDnTfUY2t9ciR5IDzo4W5322nKuoTZTaxPYoOtumptXQr/SBKfxl+7lAW1WZ4VTthsS6UbBy8ei2L3KI2RhTMHsWdz3i78pDCit2ruBqz2tbQxLftS3DG/zaPOUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQc5LURl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQc5LURl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26B0C4CECD;
	Thu, 14 Nov 2024 11:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731584810;
	bh=7ZyLogsyw0JvegtvsA9lmpsM17jAsYAfH2uhNPnrrmc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uQc5LURltDkoVym5Jv1SkNSYPAWBvNd8Q8QD7nZBIUV9H11WfMiNLSf2aTxQsNins
	 ixt3CvkM9etBvsB71n/Pvlm6zPmL6luZHCYhgAn0Yr5pHtAqUdF5AezdpW6KwLpT3x
	 KbGm80H5IO62Th7WzLzsuvMsd2ag976DiugxNQe/OrRt1d0nEMhYMUKz1NYBJ3H58R
	 ugxoKTzv7F7WY7oxStUTSMQLNz+g37YWoDOEh6TWM1QoZhMq7mlaPv7RH8Mo2EA3n3
	 WXBGaV1VpijH8uk8yXHE6olSOdfj3jGgArlI3VBepsDN7ATWPtmaECVW+a0fcXnbFX
	 v81Rf5DNjh+qQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9acafdb745so101355566b.0;
        Thu, 14 Nov 2024 03:46:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWKw6EERBtLztTOmvitRjgjZG0QMJAQskpc86sZFEnzivh324GXKx9olxQTijHOi0+oCuFC+vgw56B4@lists.linux.dev, AJvYcCWn3FXOp9upl+4SBJj5h1rBjPxdEdQIerziTSdFdENK/6ck+RpoYxfa5dVZO+ve2Q0E7VP27Hu5QRP3+UluLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzaV9vIJJ5warLmsAJRYdlwXO/csevAYTzRoNszl92/nzpmM8ti
	XadpBSt0XCjPdUC9Bp2xNhaOOKpAn+0cnfclfhJlhWXNCeiCc/2nDyFRkgTTGEgckshZFIApf8Q
	ohTgZbYdfgkq7BfC+WJeLbvBdNAs=
X-Google-Smtp-Source: AGHT+IFoq16vJdJosJE7KEK4GHjO6MRlcOMXZwElMAdWC4/i1W3KJbln9rZ+5E1RZJ1W9uq6wZO5N7zhEo+u9zqkDSQ=
X-Received: by 2002:a17:907:26c6:b0:a99:ffa9:a27 with SMTP id
 a640c23a62f3a-aa2078160e8mr253884766b.26.1731584809308; Thu, 14 Nov 2024
 03:46:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241108091545.4182229-1-chenhuacai@loongson.cn>
 <20241108091545.4182229-2-chenhuacai@loongson.cn> <20241114102136.X-knc36J@linutronix.de>
In-Reply-To: <20241114102136.X-knc36J@linutronix.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 14 Nov 2024 19:46:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6vTBwi+t8cPKSo44KZKYj8ubwv2vV4FHrNH+nG=_ZXnw@mail.gmail.com>
Message-ID: <CAAhV-H6vTBwi+t8cPKSo44KZKYj8ubwv2vV4FHrNH+nG=_ZXnw@mail.gmail.com>
Subject: Re: [PATCH 1/3] LoongArch: Reduce min_delta for the arch clockevent device
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-rt-devel@lists.linux.dev, Guo Ren <guoren@kernel.org>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Sebastian,

On Thu, Nov 14, 2024 at 6:21=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-11-08 17:15:43 [+0800], Huacai Chen wrote:
> > Now the min_delta is 0x600 (1536) for LoongArch's constant clockevent
> > device. For a 100MHz hardware timer this means ~15us. This is a little
> > big, especially for PREEMPT_RT enabled kernels. So reduce it to 1000
> > (we don't want too small values to affect performance).
>
> So this reduces it to 10us. Is anything lower than that bad performance
> wise?
Maybe I misunderstood the meaning of min_delta, but if I'm correct,
small min_delta may cause more timers to be triggered, because timers
are aligned by the granularity (min_delta). So I think min_delta
affects performance.

And I choose 10us just because I saw latency improvements when I
reduce 15us to 10us, but no more effect when I reduce it to even
lower.

Huacai



>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> Sebastian
