Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D055E377AAD
	for <linux-rt-devel@lists.linux.dev>; Sun, 19 Jul 2026 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784456898; cv=none; b=jRTpB6rP2OBQ62lj+ya9wHopQsSW3gwLTyDgvzmPdKeY+hdfgrpdDkyMLmc22m2M/oYuu4zARhaivyH+F+LUFwrjNlz0wQ//50jgs5BJtS5W95tSvb8k28KFqb8aPCmh5eF4jAiAVFcJrT1OdF/26ketahzLSEaokT3aEwoXEUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784456898; c=relaxed/simple;
	bh=g4ZZaOTO2J+J98q3MWOGEx72v4eV2zUx1DrY5sEQG0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qx9s6dSYddPuYHvfnHCka62x5hu0zu8gBrbfO3xQtx6t8+ItzmFvtVYunuCi5DioIwfJ9/7Sg3GJ1WRBlujuSzDdffwRhPdrH3nJEIAiSCGEP/ci1YCqnUPwXev88XQ/PPYR+zknKvNvjBPK2i5jEp9OpdK1G0wAUpokWLtx4qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVZkTIej; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVZkTIej"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4799b3f7c83so6660803f8f.2
        for <linux-rt-devel@lists.linux.dev>; Sun, 19 Jul 2026 03:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784456895; x=1785061695; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EAHHds1xld5SV8DD6I9qoxlQ4PAV7RbF6w4wkxnn+h0=;
        b=gVZkTIeje+4QtZY6hWgd7YV7m2lDL2M6lik6rGY56DtpSNdplNhcCMt2GvSXlLA2bP
         P0Rj6zKD+i9jVYaM13Cba49/xMGYhRaFIdBc0XVQlel8eDQDbdzbNBzBktp8ldogcSp0
         IaBBxYKg6NRBv1J7iYIoZXRWbCcKzzUzlRFDNkQJgn+Qzr8RL3/YkglEDLIgaUxy/Mi+
         ptpHFaRUCbzcZ0+0Y8MwJtVu8T/Y1acFOgV/pp7b/iyPSjPV+IIDY0MkmlmjWJT7WYcL
         ojyD/QfPlM8vv+1fK4yKIkIYDO0wxUoCddm5YIXqf3DS1gEwsDtFYPS/Gm7sSDpq1ZQb
         2/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784456895; x=1785061695;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EAHHds1xld5SV8DD6I9qoxlQ4PAV7RbF6w4wkxnn+h0=;
        b=Urkbn8HUtDaX7eNGMMAf653eCtsAYFDixC3/6LT1oKGFEC6ZgdCWEx9Xw+cYxBgzyb
         vHwIL2knJ7GzP0y5cGHFj785gOYt6dWjiHgQjua65HCVeZriLcJPO6Vp1BNB3++yXZ2p
         3QCsaJjF8o6OAHsITLKKR+mLz+dDN7pyx9Tg/k8PtwjnSnpNYcugR0E0VQL9dBOQNC9w
         rH3DIH0OnnqYC68rOe3GPjIPkCLEe5aZ19E5CCgMvFL00qjpp6zBHch8NI5DNdluozDf
         bzmyXoocul37xvvBj978xTE9GBNiTwYYaMFBWuqf6VdmOqpFu2LEmSurtLrvBLvxUUKn
         z0bw==
X-Gm-Message-State: AOJu0YxKUL5q7PeYQh42w4JcLey3vzr/cZBfiJZf/qkN4iu4f0EyBLbe
	uanCIeqbySGVk8VTm01f3dXQ/qom4VzSEM1julmVXiwwYkYf6xD50JlU
X-Gm-Gg: AfdE7cmVp3UN4lO9VrfJjIoDlLQzOgzRAh7KuyCkUXrpz0YKDQDhi5eUpbMP2uxVTsA
	bD0s5j43LWQNK8VHcfpQvw1JcAG7QeIOzZOAPZRd1U1zucbhun4jp6hHbK1n5C8XArU3eRqLdu/
	V9RLi/O9mU9N7CT1bCXo7CTlIT7A6rYl+vodJNj7CVaSvUzlY0zZxlyqddXu5QL2dnLJk8IjGGC
	/zxFVs83vPqIo1MVfiD5wnRIIkOXU8EOb02pTf2Sc5pE87pwgrk51tZLLi+15/SjhZFrP0p6UHO
	5aRTkBMz0eA1JDDo35kvPO7ls0mYGeBJV6ILgvhNaLuC4OpwP1Cr4qwIJtbvFsWasZQwHWXjjjE
	lqR1zZaYOAuR9P+lTUUebvS10DT3m8yRqIOjkaRmqVRn4MBitmpN7UynwWUc7/5VaCxeLmqSt0m
	Wpy13xTH8FEMptpP//CFWhHYjfrBxYCgmyfEtq5xltvDHiGytDS2WKcc0EggPEvpvLlZrv2ZHAQ
	rV3D4+ccuvC4Ckvw+KTFR+UHTxajAp3QNBTvd9zFzhgxbHpASv6xg==
X-Received: by 2002:a05:6000:1882:b0:47f:5c33:5eb9 with SMTP id ffacd0b85a97d-47f6233c20amr10734959f8f.52.1784456894756;
        Sun, 19 Jul 2026 03:28:14 -0700 (PDT)
Received: from MacBook-Pro-von-Karl (dynamic-077-007-018-194.77.7.pool.telefonica.de. [77.7.18.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd1csm19863025f8f.29.2026.07.19.03.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 03:28:14 -0700 (PDT)
Date: Sun, 19 Jul 2026 12:27:41 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] serial: amba-pl011: unprepare console clock on
 unregister
Message-ID: <alyjOGyTd19Obemi@MacBook-Pro-von-Karl>
References: <20260719063502.18852-1-kmehltretter@gmail.com>
 <20260719063502.18852-2-kmehltretter@gmail.com>
 <20260719070454.D6FA21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719070454.D6FA21F000E9@smtp.kernel.org>

On Sun, Jul 19, 2026 at 07:04:54AM +0100, sashiko-bot@kernel.org wrote:
> This is a pre-existing issue, but does uap need a NULL check here to
> prevent a kernel panic on error paths?
> 
> If uart_add_one_port() fails internally (e.g., an allocation failure in
> serial_core_add_one_port() returning -ENOMEM), it returns an error but
> crucially fails to unregister the console that was already registered
> earlier in uart_configure_port().
> 
> The caller sees the error and clears the pointer:
> 
> drivers/tty/serial/amba-pl011.c:pl011_register_port() {
>     ...
>     ret = uart_add_one_port(&amba_reg, &uap->port);
>     if (ret)
>         pl011_unregister_port(uap);

Good catch in a rare error path.  A NULL check alone is not enough
because other callbacks use the same pointer.

The underlying issue is that serial core can leave the console registered
after uart_add_one_port() fails. I will investigate that separately.

Karl
