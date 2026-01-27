Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923B232C932
	for <linux-rt-devel@lists.linux.dev>; Tue, 27 Jan 2026 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769506950; cv=none; b=BB05D4YokeD/GEZP27K48pH1pb1p33rzsC+aucrSACfkjb5XqgeuB7N/JONpuDcFDLBonsUhFa82eHUNT7ACk6cuq67cvW0HZSD9L0w1/RzxZQLfZuh1K+5W3OB+xdDuhFxJaITwgu+Oe9ySxBBTbDxl4eIoFTOyBHt9A9/g4Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769506950; c=relaxed/simple;
	bh=iEzaVGzmOlwTp8TWch0rAvCSubtbmBjxCsLlT6mn2+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWyWAgIusein2msTnluGrH5tM1WEN0eGfPb1NatI7hp65K3OmlH1SEH/rr29L18v4SZ00jDx5BQhuJ1YCHTOupuY6NE73zH5b2RxjVColI2tTmm7GMZn0036eLvCYXeWr4i8ImWAycLym9J3TGgNYNQp2SUQH7aGZU7ZY+hZkEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Frfuds7D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Frfuds7D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41304C16AAE
	for <linux-rt-devel@lists.linux.dev>; Tue, 27 Jan 2026 09:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769506950;
	bh=iEzaVGzmOlwTp8TWch0rAvCSubtbmBjxCsLlT6mn2+0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Frfuds7DWSBNrGkD5O4CtIJi05+cnwgq/JUihQJX/m8Nozz6VRf/wbbN4/4MUxjOF
	 JwBIE6No2i5Y3QacilMnVKteX8MihHl3UkRJgteDDV60uYnMfvcS7Gv3C4aOLC2XtW
	 Ep65A8z4Y/3qrlW93fnviuwfI1IMKGSsK7tLKodcrFsKraAf1dhoiDwmAHJeolPik/
	 jtBof3OagfKOFfXLcPVRgwWVh1nFgBZygVooTduqPQtk8R2YRfyMyxTZxVkR/DUpAr
	 xojQ3MBHhfFu5kCgfQYTfZ+Vdvaizgzm1ccIelB4K93ODDUBVw7zHfMmrF+I+HiWvY
	 jJJai7qlwdaqg==
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-648ff033fb2so5025489d50.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 27 Jan 2026 01:42:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVkgMtK79WgBqHlsDo1M80x1pv6qGvJTJ38x4NQ+4t8v4dSaT/T1M//gsvRhRqdgvGIaiVifxTcNPYONHKZUg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzn+TDD7S4TooCOE/E6NjIvbmbx0dZAnrkeb6VRAIyPrzN10Awt
	jrSXmkJ9fMMUrRfKtbdH76NumomHv28stD2repCGiUCrkVoS3Mfc2j0NBUSCoWc+lfZG8Po1Wez
	KZitNPopZMLHYr02U7KIu4AAzD+xLb54=
X-Received: by 2002:a05:690e:1882:b0:649:6b00:7274 with SMTP id
 956f58d0204a3-6498fc943d8mr589929d50.81.1769506949581; Tue, 27 Jan 2026
 01:42:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260123113708.416727-1-bigeasy@linutronix.de> <20260123113708.416727-9-bigeasy@linutronix.de>
In-Reply-To: <20260123113708.416727-9-bigeasy@linutronix.de>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 27 Jan 2026 10:42:18 +0100
X-Gmail-Original-Message-ID: <CAD++jLkBc8WRA0Mh21BDnfAw+8+J-hrzZ6=AzJ48H2Ls0KaXqw@mail.gmail.com>
X-Gm-Features: AZwV_Qjt95n8nm-M_W3ook7H-ev-YocCp6cwUWsCLk9XYockUegysYTnA3358YA
Message-ID: <CAD++jLkBc8WRA0Mh21BDnfAw+8+J-hrzZ6=AzJ48H2Ls0KaXqw@mail.gmail.com>
Subject: Re: [PATCH 08/21] ARM: versatile: Remove IRQF_ONESHOT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Thomas Gleixner <tglx@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 12:37=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:

> Passing IRQF_ONESHOT ensures that the interrupt source is masked until
> the secondary (threaded) handler is done. If only a primary handler is
> used then the flag makes no sense because the interrupt can not fire
> (again) while its handler is running.
>
> Revert adding IRQF_ONESHOT to irqflags.
>
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
