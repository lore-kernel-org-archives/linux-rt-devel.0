Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E848D47252C
	for <linux-rt-devel@lists.linux.dev>; Thu, 17 Sep 2026 23:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789686869; cv=pass; b=OLXrW/zDLvKY/Nd8gOauZ0joouAGXNhUsmqE4FSpu6in2btZe5B09I/ZP6/37OHXwlnqiRVmnIiyUNzh7+snQYGM2b/iaCaA4q2TrSuKA11o/BrRoVekCs7cdNB9ue3N4cVsN/Ax/xK8+Dn/0baHbPvKNgpYbGhdBQv6xBe40nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789686869; c=relaxed/simple;
	bh=UFVnKLmRNthZe/OMD8aBRH7cExiAA+7lFKrEVyJSMFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NjluYeDydUs0wgqP+MqJsBDhquZpcPxP//XvVOKhEDlZVW8hlDKI7cyeUh9OVYPL6/+vYB7ucPqLMZ8KDo3YM+7rVhvdze61pc+94rpzcwdtzAj/aY/dTFWBDdOKwQEA9YXCZLnDKmn142n576ANGAj33Oms//qcv0NfXVGI1OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deJTucGq; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deJTucGq"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6063d7daaso180498a12.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 17 Sep 2026 16:14:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789686864; cv=none;
        d=google.com; s=arc-20260327;
        b=bunz53cerwiK+fsAaPTJkfYUAX8m77wKks/C3yx12VuzCkGN0PcQ3lZOrPWoc7oxes
         91OCXZG4Zr7GDzsVwYC5Ed5EuJTEL9rrAoqearWoewIOmxMyD3sqzQZd0QOKVUFB3DNx
         GJu/64nZ/ueDL8CH6R/snzSoOZ1FyXd/1Csm7rywK+wX+cDV3fnva/Rx55Jft6K+TT6T
         aGEsJf8kFRSLX1kcSbi0zZxElmEK0k9X5bowtspVJFBSFGEmBX/fVqG+jFQAaMPJSuZh
         lBS4dFQGAqmYVCidnkONe3AU3XBRJzdXZDRmBNDUtW8DBIZ35RveYJx1i1bioreAxew0
         ZKiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mCrPUYkHN100Be0rJWvwG/WLDMRSEYT5rdHDdeTuTGI=;
        fh=QCGr72e1+idRt09XsrVXJhsQsvaIpYeyj9dn+RySrAY=;
        b=BqADGsoPsNvMRdJyYh4YMbB5YVN3nK08MWgHJYO2+V7J3X+5pFAvdiNzL6NIWbeq9p
         OS9vRru0sRPj4G3ZUeD/sB/+41EdiekNgYtSiFdL0Qbk6tIp3+iPN6sP5jlHQlecP2tE
         7YHGujQON5JacoOg92rkMaOOFoOu3V8YGHUeUg7QNZaWmFPviQnrXTKspgNVcWA3KxDU
         vYRleM6OQnD+Zp7J1fmQPBF53bvfRqQviUk1OE6BAtc4mKyq9m2DYt3yrcIrWKmqNqGF
         3EZFRyqoP+Fs85g7U+1wQ4XByTPO2BNdIGM7zVSD6LNyl2eAwF+3FWlF3X2m7EsrYc0f
         cT+Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789686864; x=1790291664; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mCrPUYkHN100Be0rJWvwG/WLDMRSEYT5rdHDdeTuTGI=;
        b=deJTucGqjcf9kU8Rq7KWu/QMASFsCBfXKApxPVAeenY/58InIeZCNGE1HSMiwYjRcy
         W9nFGGEz7BauPl3GVQr+hWqfi8AHq6oe/eAlK7mvuidCzc9ALEV28cIWSLLDr+Jvsnr9
         TwuppBBAYj0pw9/KN4+wK4Ax/jv9onqOTkxJQI60uWJtmlggAUEuj48Whxlx130fkUFG
         oZrKvviDzJs2RqBRWt6aCiZmx/UUDk84pyNxOEORBOwxnk5qtHhB5qEZGTdrudxGz38W
         +KL+LFXFkjCGHxVYUtSQAE+j6FzF5b1r0uL3ln9Fw9NsmudCm79wKQ+wrfRz+KWx3MPJ
         WVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789686864; x=1790291664;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mCrPUYkHN100Be0rJWvwG/WLDMRSEYT5rdHDdeTuTGI=;
        b=cBPbrTdbRyBrSZLF0mYJn1GZSFEynelLR8tZXsbbN9FMUhQ49iaycfKXSNFKvEFb9L
         ChVvi3xEAmPwl6AbDXaFsY2v20ON1pCMhpYN6UE82bpbrlGvUvEtMVMVdyR93KJfukQS
         LNoWb1Vug+pJ6N7zKwy1CXciTK9lI5aqol//BptAnKpbk/PUsfaRlT+PrxgtOp1udUcv
         nRTVOtYkUplerJ0dRUD7/Mefy2qgJvQ2f8g0/2TYJ+Sb13yE6VM4YyEcP1P9+VDVwG0X
         tX/ceSoYPcVqNjS7ZUcIxoJPb2JeN88q/42R27Hfp1STRTXyHyLJXubg9n5MxMqa+xWx
         P6oA==
X-Forwarded-Encrypted: i=1; AKwUvBycdzOgJDPr3XsZ3US/1DZmVw7crPyarxiPDa9gDMu2KiTgMBmuBP5HeoDC6jQxdEeI4BUzJuZNTx4gWydGNw==@lists.linux.dev
X-Gm-Message-State: AFuF++kXPl1WlLqtzlA00oW3uBi2wxgw3SowF5ZDC5QrSaMfNd81ylP2
	kh5s3/aC+U2ppQzXXNRTZ2T03RZqjVl/gc4JbRM2BxF6Q+VtvntCZb6cO7hk5tXWD3LEhWDABt4
	oltJ0LiGJq4ItnFRacTDm++xyQTOh/gI=
X-Gm-Gg: AYBFou2a5l7uGzLueaFM2h1AWHhVAjn1rkzIijBJcZIFxexHoYrTV2u9q+sWhLk1SM7
	FsyNTD/FKu06e1H84aOFZ2Zui/LPBvUKdgThJln2gJWd87L7PcfKS74//Hp61DFWKiu9CRt3a3B
	QrJqELiiSJOqLxGQydllAE8AwwPsQyl/HA8d873vRMqTVISoNeXyQqO6PwxR7FZ7XCZKe9YWI9d
	dEDc+fS4CETU4CcucpJe6fpBWL2q7cKhM4I/FdTsjyfXoXzTF+WaJRMznjqHjzBCZzLqV2vnunr
	fSHYqZ5scO1IRQe5UNum3MwNWYiFfIvP6pqs2OrI02iC1J9h3GCUKzJhhQ5IHubLieVYK8UaaeO
	xtoAc0ybetVOwmP0zf6nFggSrjaFj24MJtYcsvZZI4qDK+Ze+CLUBEHFEWZubfeaqy0WEMksdjU
	Oh2TW6sajU3oaV/NO3tvS/uwRlVneO8/OQhYxC+RZOIT3w7iQnrtD4TNswbP2qtGeIvw==
X-Received: by 2002:a17:907:7243:b0:c29:d522:b4fd with SMTP id
 a640c23a62f3a-c2a1569a29dmr71257866b.4.1789686863785; Thu, 17 Sep 2026
 16:14:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260915004406.115230-1-rosenp@gmail.com> <178963874726.7902.8784965092061133801.b4-ty@oss.qualcomm.com>
In-Reply-To: <178963874726.7902.8784965092061133801.b4-ty@oss.qualcomm.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 17 Sep 2026 16:14:12 -0700
X-Gm-Features: AcwNN1XHKFMSTs1rl2RD8k1sqDGvHySVlRMJaCZsDUk12Qjnpdg1iBIpXWDNCU8
Message-ID: <CAKxU2N93W=fPCBiB9zDZOYNT8JwN7LNOcftBfY5P_LFRYtWu=g@mail.gmail.com>
Subject: Re: [PATCHv2] gpio: mvebu: keep resume masks within the irqchip cache
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 2:52=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
>
> On Mon, 14 Sep 2026 17:44:06 -0700, Rosen Penev wrote:
> > mvebu_gpio_resume() writes the edge/level mask registers saved at
> > suspend time straight back to hardware, bypassing the irqchip's
> > mask_cache_priv.  genirq skips mask_irq() for a line it already
> > considers masked, so restoring a bit in hardware that genirq thinks
> > is still masked leaves that line unmasked behind genirq's back.  An
> > asserted level line then has nobody to ack it, and the moment
> > interrupts are re-enabled the chained handler storms, hanging resume.
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] gpio: mvebu: keep resume masks within the irqchip cache
>       https://git.kernel.org/brgl/c/02af7eac17bc62a72335c1fc8c4af4471654f=
6cc
hrm unfortunate. I had a v3 ready for this one to fix sashiko's issue.
I guess I'll send it separately.
>
> Best regards,
> --
> Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
