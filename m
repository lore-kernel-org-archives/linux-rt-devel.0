Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1DC1A4F3C
	for <linux-rt-devel@lists.linux.dev>; Fri,  7 Mar 2025 19:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741377090; cv=none; b=vECDEgxLVcD9h5KqUEjpVWBwGsAW592gFhy2kuL6ol4IUWNHRJE1LclkFC5IjB2LY2dkWj3XAMVKsoWnvzVUI5gK2qdLi6iX/4aHy9YVqy4OAe7Dg/WyNe8tDc8r6j/p3TYM8DQIMsTQR5r4iel4xOy2s4DLAEe1BIxMKJLBhFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741377090; c=relaxed/simple;
	bh=DIWtNK0/73Tp14vlsnzpFPmis/W+TpJ+G7ZVFgBV4K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CY+dr3svH1CTEgjVVX2og5kEnwa9elOtQE0yrjin59/Mi7MEaKjrX6ORytXUYSko7Hh5L4p5kgNUaCkqej2NQILcKnbnt9Mj8jLqAyDX2BeABcWAyRLMZA5/83QD7DxgY6Xe9C9Pq6kqL+8tVFdfaYaS+7KabRNrBaxza6NEeM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SowLOoRQ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SowLOoRQ"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff6ae7667dso4480669a91.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 07 Mar 2025 11:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741377089; x=1741981889; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0vxeJ91cIahvPFsZ/TUnYjZG0BU3sHhaPEfqVVFDFQ=;
        b=SowLOoRQZ+Ba3Tjj5bDkS7Tbr6bObCF/9PLL4VVxLibtoe1iLlrg1ISDqcPbRn+CZc
         +l3XcfiqSGwVxOwxCe0ftNPK7UPYAiFFi5chcHRE2g7i+UJnukdYd8XZZZWWOVQ1gvMM
         a4Oa1WJQsF/pcArY8gokbtifG/gULuo8V6fuf6TZ4w/XLiGOsfyzL2OqaYT0X7ejahpl
         P+yIPONK901gLf0AijqMqU9smeTBc8PSo5tHSyNxarngGX6kP7VWihDn2RnHTFec+fFz
         Bd5Hy/+sDKSxFDB6/jFEkAfKz7RWGItNR5ifDXS59F4jqLaj+UzPohoZ8CugtZb+czic
         PkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741377089; x=1741981889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0vxeJ91cIahvPFsZ/TUnYjZG0BU3sHhaPEfqVVFDFQ=;
        b=sF8L0Y8hR1kT0ZT13oDudXWRgdgaeEfNXxsRNRbZ9mlBQwhIeULw3iETMWSLy3c51a
         nAw572sPscC7BvRDzuRLLsERwrci/Qu7uePBQlYQFfvKdZZMc5WPIYdKCPRdpatBbSV+
         7FIq0iTrcCQijbxaCELnuNg+FtJ01V8cGgiG2Ri0D9K8YXXzvHoQbXKtJecX+vX4S9K7
         5/lYdAfN9CadeVl0Wl2LKAD/BHEk65klCxxnEYxxZLipOceSVPoXuvQg6kDkyHZeTUf5
         eMrZN3QApUw/oweNSTNneItYFTD9zXlzqjiTV7ipdGsyHzx/zb8FaBngAws8kCuJQdZO
         huAg==
X-Gm-Message-State: AOJu0YwBifm/Ef6Guf9r9d3iOmX0QZN0J5zpu1ppDP1NcQV7jgf+edfk
	skUgUwb1bkhm46onAH8OYvB6VBhEhnbPnyEL+az6NY8dhhsI5VAg89zADFXziaObjP62+wF+7z3
	xJq8sExztUDwUN4wd+2Rk0v1SgqzuraYmtQC2Sw==
X-Gm-Gg: ASbGnct9mvn855MdXQ8/ipBa2cYvLVgIXh91OiQVswpAQuVT4EF+GMND/StOU9rObsB
	wnPIRL8LuSdxUbAdq6HgAh/Mjg5idm+U3pOhKTGmRpj4AaYt175KTKkGyApRXTRvKVeyXy3lIY0
	ZPa76gIiHFJ/4CaLKqvVUHCGZ84w==
X-Google-Smtp-Source: AGHT+IH4Wpg5uTuvEjCppI+SSHGZ9QA7hC9F+4K74GBw5+jVeQ1H/kZBYBQf5cw61pm7FTEJp+iAMqFFaLciH8g3+zE=
X-Received: by 2002:a17:90b:1d84:b0:2ee:c291:765a with SMTP id
 98e67ed59e1d1-2ff7ce77c29mr7469398a91.8.1741377088779; Fri, 07 Mar 2025
 11:51:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250219181556.1020029-1-ralph.siemsen@linaro.org> <20250226082931.-XRIDa6D@linutronix.de>
In-Reply-To: <20250226082931.-XRIDa6D@linutronix.de>
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 7 Mar 2025 14:51:18 -0500
X-Gm-Features: AQ5f1JoWaLOl0ZjijIjOgwzx3_177Kjyj88yLqLIwYi0VFpiqFBpb-h1H7TnkV8
Message-ID: <CANp-EDYH8YF7ga5oRPrawhiveSVwW0w7YosHGJWuCKd4TaApDA@mail.gmail.com>
Subject: Re: [RFC PATCH] usb: gadget: u_ether: prevent deadlock under RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pawel Laszczak <pawell@cadence.com>, 
	Frank Li <Frank.Li@nxp.com>, Ferry Toth <ftoth@exalondelft.nl>, 
	Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

Thanks for your reply!

On Wed, Feb 26, 2025 at 3:29=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> Based on the backtrace the problem is within the cdns3. The driver
> acquires at the beginning of its threaded routine
>         spin_lock_irqsave(&priv_dev->lock, flags);
>
> and then before returning the URB it does
>                  spin_unlock(&priv_dev->lock);
>                  usb_gadget_giveback_request()
>
> so the lock is dropped but the interrupts are still disabled. This makes
> me wonder why using threaded interrupts at all since interrupts are
> disabled for the whole routine but then others do the same.

I also wondered why threaded interrupts are being used, but I don't
know the reason.

> If you look at dwc3_thread_interrupt() they have local_bh_disable()/
> enable() before acquiring the lock and this is what I would suggest
> doing here, too. The NCM is probably not the only one affected but
> everything doing network that may since it may recourse into softirq.

Thanks for the suggestion. I had also thought of doing this. I also
noticed that the "cdnsp" driver has a similar fix in commit
58f2fcb3a845 ("usb: cdnsp: Fix deadlock issue during using NCM
gadget"), which was also backported to stable branches. So I will
prepare a v2 patch to do the same for "cdns3" driver.

Regards
Ralph
