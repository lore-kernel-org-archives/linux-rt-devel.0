Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882EA3793CB
	for <linux-rt-devel@lists.linux.dev>; Tue,  2 Jun 2026 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419118; cv=none; b=WSMfkNkbQ+TlV3KJqkQgHGWFcbgv6voWzH8YgOIoqkoNguWPg5FZiaGWwqjyJhtadHOn0rxvw+keU8Hp+n6pRxIBQVo9ZhOoP8LbKq3x7g8m1zPIhGDQC/sU1duSQo3mrjnlFH9LVHywOF9nqP7IrObYzMx/sTeekkmVnx3jZUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419118; c=relaxed/simple;
	bh=5Lj46uO9+RIj5Cg5YgOgH1QwqHsxMM7alAfKIbkaxoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLsfagEVZaf3vFRO4c8sFF2piQ/iOmiDDwIN2F+5F6oX1V/1XWRskUTmkk69zY9CQArPQy1k6eR/5KyBnAwhgnIuWKQGbFEnJzKaCsVRnd3xG2NQKS5T+OW5rjEFVCv5evObcR0/SDIXT89Ux7QArR1LWwqAMNLTR6UmXzslnfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=urCjA07z; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="urCjA07z"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-842264dde84so1602343b3a.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 02 Jun 2026 09:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780419117; x=1781023917; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nJdp4XF3Fcb1uyz/I+762d0PZHcMV95pqLsyirgwV5U=;
        b=urCjA07zSWcGyV8tld0Zvz+IbWdlCTTfQx4h4r/G1zrjn01YsTsOXIizQIrW+Hcpe3
         U9keaZ5D9E5WYUEGeWjsD7az9KelqNr2qx5me7ll+y5k/eMQMvUaZ6pKrKrZxcGUcXih
         N9nSd5dOrwz5aCTgYI276lHNSOAPfUQdMkM6jM8va7A6PSTQF6sjE3Smnw2ym/wh4m4i
         D3adImcGKyp8G6MBm5dw+ckfRDVj2Vzpsqd6tsJWDhPZmVVIHZo/5j+Sm+pzRKKNI4C6
         Em1Oh/gPCWhcAArr/B9+4jZCROBbdy9zTkykblcHVI64K3gEyafwvHxouTPC9mDrKxA+
         JSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780419117; x=1781023917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJdp4XF3Fcb1uyz/I+762d0PZHcMV95pqLsyirgwV5U=;
        b=SXoHO8k4cmS2PKdv1h21TpXX0nTSwHqmm9fAFX/+2ehQEoiy3vJ2v+tpKAX/xhioNO
         mYJhOKwYMijLZMlYJ46xYH/GvisgNpj8jzYEhHUNEy4DI3JusCJ89IpO0sb4x1Hz1hyH
         O5wF/wx4gYi12AgRkLzDkM/OglqH62+ZzIPVeDxC3VMXtDccDuq9lApG/MxozeR4RRfE
         SEdo95nnpZc0UU6u1F1NhSOVqMGNtndQ/Wb1uu4wxmS6yigBe280FJKQnawXDruop/kc
         9qwJLleJ9rK+fdU23UtB7wnROwrAEacwWnu/zD1KvOSLKrxDK/xLmae4xgKh5iuCLWNm
         v5lQ==
X-Gm-Message-State: AOJu0Yy931xnpjgJWyAaNxgOcS+/EE0kLVpJQKa/snHGT7R51Lose8uJ
	ZVTaY8XSkUvirPqwOCTxwvjKeWKwargcKXvXzFp53vhmr4I6h8+ixYq3dXgITjeMibE=
X-Gm-Gg: Acq92OH3hVKQzoJGboDdpiBRHIBfA8q00Yvtp1tA2hLoycCp74+Dzg/GfMh/04Z1+ID
	woN4FyUsD8HQ0DKtVK3MkPBzEc7of4UAdD1cNJK3FF6metoaFrwFLm1ZN2T8dXMUmVX95y3fE5h
	e3l50URiJDvs+FMvu7pIGVHVfs4BbcXaHa+jb/IWIYiKe4+HC0a8V3T1VpbiHAljDUfsLOtBJQ9
	JV1mM9dGck3SzVF4XBpYlcWHRkfbpEWenD3aIbewrVyuTYNXiUMal6M9RQ5OsXqb/V0Avz8DqZK
	L/ucoG6nBefqRzBXf3B2zU9EMi7Bo9mEPZBcffq9bz32t+83STIa9ZWfvJzOOPyLf4MHepKRgFA
	90LpugDUNFCbIL+OgHOUyET8RD9oKOXbCVzaUdhYaED33BASRxP6zYVsFRPyc6atKpR/TJmol6m
	tMwpXwIaZ0jU+7CGkpyox/afV5JKr3TJmjpzeuePqEz+Sx+YoB
X-Received: by 2002:a05:6a00:a112:b0:842:6259:5e2b with SMTP id d2e1a72fcca58-8426a96af92mr4013059b3a.33.1780419116687;
        Tue, 02 Jun 2026 09:51:56 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:6f6a:5e58:19fa:e0f1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282372a16sm399509b3a.18.2026.06.02.09.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 09:51:56 -0700 (PDT)
Date: Tue, 2 Jun 2026 10:51:53 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-remoteproc@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/5] mailbox: imx: Use threaded handler to avoid kworker
 in imx's remoteproc
Message-ID: <ah8KKVmE5qCGJ1cs@p14s>
References: <20260529-imx_mbox_rproc-v1-0-b8ffc36e11e5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529-imx_mbox_rproc-v1-0-b8ffc36e11e5@linutronix.de>

On Fri, May 29, 2026 at 06:01:02PM +0200, Sebastian Andrzej Siewior wrote:
> The imx's remoteproc driver uses a kworker from its mailbox callback to
> complete the request. The reason is that the imx mailbox driver invokes
> the callback from its interrupt handler and the remoteproc callback (at
> least the rpmsg-tty) requires a preemptible context.
> 
> This works but is problematic in a PREEMPT_RT environment where the
> latency of the invocation is important. By scheduling a kworker the
> high task priority from the threaded handler is lost and the kworker
> competes for CPU ressources with every SCHED_OTHER task in the system.
> This can lead to long delays on a busy system with other RT threads
> which are less important than the completion of this request.
> 
> Looking over other mailbox driver, like the arm_mhu for instance, they
> use a threaded interrupt handler to invoke the callback. This avoids the
> kworker detour.
> 
> The here suggested change utilises a threaded interrupt to invoke the
> callback. The primary handler mask the interrupt source so that the
> handler can run without getting interrupted by the interrupt again.
> Doing so avoids marking the interrupt IRQF_ONESHOT so that that in a
> shared-interrupt environment the other interrupt can still fire while
> the first one is masked.
> 
> This change was tested on a im93 board with rpmsg-tty driver.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> Sebastian Andrzej Siewior (5):
>       mailbox: imx: Start splitting the IRQ handler in primary and threaded handler
>       mailbox: imx: Move the RX part of the mailbox into the threaded handler
>       mailbox: imx: Move the RXDB part of the mailbox into the threaded handler
>       mailbox: imx: Don't force-thread the primary handler
>       remoteproc: imx_rproc: Invoke the callback directly
> 
>  drivers/mailbox/imx-mailbox.c  | 65 +++++++++++++++++++++++++++++++++---------
>  drivers/remoteproc/imx_rproc.c | 33 +--------------------

For imx_rproc.c:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

You may also want to fix driver/remoteproc/stm32_rproc.c

>  2 files changed, 53 insertions(+), 45 deletions(-)
> ---
> base-commit: 9e171fc1d7d7ab847a750c03571c87ac3c17bd84
> change-id: 20260529-imx_mbox_rproc-7d512f5a6f78
> 
> Best regards,
> -- 
> Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
