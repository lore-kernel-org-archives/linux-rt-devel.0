Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145F021884A
	for <linux-rt-devel@lists.linux.dev>; Fri, 30 May 2025 23:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748646771; cv=none; b=AXw2JCIYqy6SzdW9b1XFqI4TRrztHYbwnE97L9jZIjCyXbNJtUHkkRZgXkT1sEIQiuKdKwBd7VRZGmB6jT7GC1BdYuLuu/mfJFfxKWMyU4bwp1S5Waz2xQbxFKrsnjMB+SRt1VR0h6meW/crIU8R5ZHW0CLfDTWYRjdYdO+0wFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748646771; c=relaxed/simple;
	bh=nbrt/PGJxMyE3yw1a7SCXWcYovhnujWuWgoE4oy4YWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgP2eV/pUw/dJZ4ng5xMOPc3tnAXRW3zMp0HxhRBwroNWIxVrLNa5jHmgeF8T3JeHwNSHTx1/iHOrj8+BxsJQB1af5VhxEyovIHRAGy0aL5psET2GYpXRgIL28kVfCsaWSmYEp+MB4lJ9x/VYJ1gz8ApKvIUoIToq+g1Qn9FiA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivo7llCo; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivo7llCo"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso2127542b3a.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 30 May 2025 16:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748646769; x=1749251569; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MqUM//8SfQwKzGfaGh29crkUGUUF/A3WL9Up46EW+mM=;
        b=ivo7llCoq7TpruRPeap5Lpz9AMjkD73xFcjTz6ygiCHhXG27ukKZTmXnJRrlYvqrkq
         67xTTM6U2FZ1i2fFF4RIxgtLzueLqmSeo6KuYCnU6Fb3hHFSmfw8frmJb5iekkT+P5m7
         CCfpcaT8FgUQQy11hfDQh1vDj0NOmj4ji4pfw81M0p1xOP1+URTjBPJ3TOCQkMBDHbjz
         n+DTrL2qA7VTL/SPHdyFtxcbUI42q74aaVclwV93Y2mnaLLi9jsc6mtKohXkbCn2lJJg
         sccuB0PNvCcvBuDqwLeI0c9ggNEhmGbPvuKF4DTPvxUZVJ4MLb7PKaDHAFs7e9JR5SlC
         4pTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748646769; x=1749251569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqUM//8SfQwKzGfaGh29crkUGUUF/A3WL9Up46EW+mM=;
        b=WkD/K4WB4oyjSfJEhGf4I7D0O9gsz4t0TmVEWBaeCbhNTxmAQQ6ZgKiHuNHBXiL3Be
         CD17uKICOKY6w26ky4EsMwnLZA1+E43lsQe1KH/ZRJeNLsOssYAzbdnuHGOiYoQfgMA/
         /UNJaUWvrEhPcV+nM09rqGxv4BAEKTAJrFZg2A9614d8mInkD9xptDCTV7fvE6lD3iho
         3UG29SvlixK2gALSWvoy9gggJUamY5R/0UWgn4qJdAAo3Podkyxy/XRxEDtoRmUNNJHC
         gedL7DcXC1ZFA4qfKe2137W5IKPAKsrN4tt2jkaxurJnNVyX7OsPAYWkRhOJ9a02pXJd
         5oQw==
X-Forwarded-Encrypted: i=1; AJvYcCXSSLOaUKMnQWLJa8Yoz/hk1TDnau+/9eU7s/agat+xjCfNzTgetMj58LUjE7BzRJG8CwuQR+mWlndJTOwpyA==@lists.linux.dev
X-Gm-Message-State: AOJu0YywSyz+degWtuuh0yapU3oLbfZB3ghIVmFvXg0iGdJG99wtU8V5
	fxPcz2U1QLdENE2F+NOvTOQ8QhpyL4xrdhEpnkVTgPGwWkiW5RtuM6ct
X-Gm-Gg: ASbGnctVREROFuHvnRZJNi02MuNAoh7Nro/BXhEtsEe+ZlR8o+zx0KUwO9UKCFposcU
	KO1xx7j0Vwts0j2D5OlfjJ1AlA1DQIbbAvsyUzxGMUJultL5QKO/G/9d9BAInYj5BwYSzHDpVG1
	EBrYlrQ0w7POmsGRkmrX8ISRyRq+hYYaR+hBU5qhejBLc6EAMM9DOJcHuCv7Nm03bqOVSIBhlqx
	UlTMHxo8qV9Q9IUyd7x5uj80XFTxC4PYwAYFfBnArDErbZkJnO0pE2tP76avv+KS+FFJN788e+M
	gh3/OJXFA7W23ifVqAjSkkkv8GTiTg3rfI2S97VOQ72FZ/+g9UCZ
X-Google-Smtp-Source: AGHT+IFHeyI9jVuPAyDeBaVv7nMJ1xnzkjCCEZ326DeO/nr42OA9VJ/9hB3rIhvTlv+eLYcNY/yLfQ==
X-Received: by 2002:a05:6a21:164e:b0:1fd:f4df:96ed with SMTP id adf61e73a8af0-21ad9764696mr7528449637.26.1748646769223;
        Fri, 30 May 2025 16:12:49 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:24e0:5639:ebc6:8c16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affafb01sm3670106b3a.104.2025.05.30.16.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 16:12:48 -0700 (PDT)
Date: Fri, 30 May 2025 16:12:46 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Paul Cercueil <paul@crapouillou.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, fabrice.gasnier@foss.st.com
Subject: Re: [PATCH v2 0/2] Input: gpio-keys - Fixes for interrupt callbacks
Message-ID: <ozixu2kocpxmtlh5mymdpm3hlovtvrepoedcu7gafqoxchcyjx@h5ajy7ujqye4>
References: <20250528-gpio_keys_preempt_rt-v2-0-3fc55a9c3619@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528-gpio_keys_preempt_rt-v2-0-3fc55a9c3619@foss.st.com>

On Wed, May 28, 2025 at 10:50:20AM +0200, Gatien Chevallier wrote:
> This patchset fixes a "BUG: sleeping function called from invalid
> context" when CFG_PREEMPT_RT is enabled and a possible concurrent access
> on button data between gpio_keys_irq_timer() and gpio_keys_irq_isr().
> 
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>

Applied, thank you.

-- 
Dmitry
