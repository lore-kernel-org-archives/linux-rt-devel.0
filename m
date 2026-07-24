Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75EA41F350
	for <linux-rt-devel@lists.linux.dev>; Fri, 24 Jul 2026 22:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784931754; cv=none; b=EicSf15sbVEZf0b0TE3tRfOyPbjiX7zl5lBzi9ZUICr8jLHszybHwQi18DYW6TuhmaHQ8YNTYfoV5nfKZL+kS/sm40MwiCMTXyxTvCn6LCtBBx694XT48m6V38vnoi9zI+N23LZyz+Hq5OH7APFs5WShDTaLXp7haIS9/x+FKpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784931754; c=relaxed/simple;
	bh=AdYfFyAgjIVO5XDodIBE9fbPfdcVANsXvv95CojMIRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihpZ9mXMo4sNmn9/rPwGBdN1vqcGR3xLD927PUhBOjJ0KnVwz88gygQ6qGQ5ssi6s18OtDc0LmQCnzI73tOKUt6hbotaRHZDEFX5pa19QIYtTLQRqbTZfavcYJjgqEj2z+bkxKfh6GtlzGVRueBvZ4h0km1n5P12yT8VQNVRyIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVewsSru; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVewsSru"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-495635a85d2so7962085e9.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 24 Jul 2026 15:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784931751; x=1785536551; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=chE3xpVkIQFW5ArPDZ32cA7aJ2wqUwJA/I+4bx+PmKI=;
        b=PVewsSruOGO4WSULgaqeIghslQwzN3U3PfEs6jzZu7hSFLh6fIC6BDUA+ArDqi76RF
         rsMfLXF27HNBoGfVLdMR+bsBFb2cM10Y/lVdy+4zGNaBBHSB4Ic+SEi287YSn4jm2lXP
         gaypYZhcwqEGOuuQ0zgge+VoFZPSp35Qe8nbQDvXIlaLordLXJ6iSpyAE6q328jEViKt
         neEvNygfc0dKXqHVrrnEVwyqxrTeJ42NuPr7q5u9YefvR2yE27StqNrY99vm/g/DQYH8
         ohEIN1YDofALyFO+q4P2HetqyjBshImLI1kkIrqac0pjgFAsrvXS86ehRtQgO9dYNB9E
         WynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784931751; x=1785536551;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=chE3xpVkIQFW5ArPDZ32cA7aJ2wqUwJA/I+4bx+PmKI=;
        b=KkP5/Xg6j/jNd5HvDpHJXyav8v23+NQO+GxAuwZ0xIFZhXmNsaZmfQqnVU9ltXZu09
         powlqCYUMSqZYBFuX6SAcqwKLphpJE6MDIf2Ymsbf1m19agoOTMNtu/Ic+UFgsB1hQl5
         lcDUmjGeP8EnNW4uDxahRvChhNv/r0Rrfl504b8HEO/IqrxnKNwi62LYoRXR7LMArYSE
         vNvVBNAhZAPzqFmwwlJmCZNLm1Sfe+Be3JK/mX69frXMwKCR8EE6yshLHcymUamVVR9N
         uyMa4eMOSYX5uLCxODz8ktUdQdqmjDVhzY/3zrnB5gaLouhuziBApvkiQoYWdnOtEePj
         B/TA==
X-Gm-Message-State: AOJu0YzK1dp4d0B4ak3vSl/fFDLbFol/BnOP4F7BazfLJuyu9Uyr0xD+
	OBwI/PBnBOBDV0crxCmR03uZvIHKPQPQd4v6AEm4O7ZR8/7JK/A9dRjO
X-Gm-Gg: AR+sD12S/TYj6xZA4jxOmB5tHIQk5yT3WMvhIuppVD/KIa8xE8Pppw80cSBHgCD8T5z
	mtNH7ZstzyIz06oq53/bFwplqXlggj18akM7ooqr+8brYKQRe2fhcVSRwGPMvFVtI0V10EDXjeL
	S+u9/HZjtBTB1jhGiYyzRqRfbLvioph6pXcAUTAmmiTdiV+8wvUsRE3RWDAU4US4nbuJdWVtBQQ
	3ONPk5aDlYMseGn32ngGpwG7xZWo3hZAP9xRjxoC95bgyAxq+OeB8Ab9WjE0O33zwq8eod+5qHi
	5ZdroDoS8c/uZVhpBsFYa8o9uGuQjHwKsPpqAZxv7jqVtOVsj0WCycvcOkc+EWxZiBKFvmJwN0Z
	wC+0tXVHxFPsSeDOfhU+6mkr4LeOXE2s1Q303fd08crz5/NB7ta5Bc4gnAeHvOAss7fDW27FBeh
	XPTB15ba/Rkl/cHK1mGqFu3Nyv+axzvsWkeO+YHKjlm37qmkijIN2QqjsbKEm3vvXwfCd/KQQHM
	/yEMraplyH251/A6xGKfQorz5uLALd8ggzdeXbiQ++T2xbSIUZ/26owJM/GFMGEwZnq1c8wE7p5
	/nuTcsnFPAnZY0SB
X-Received: by 2002:a05:600c:a00b:b0:493:c182:6b08 with SMTP id 5b1f17b1804b1-496b570f64cmr1640745e9.36.1784931750842;
        Fri, 24 Jul 2026 15:22:30 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-ae93-f301-cdd9-d5ea-080d-9131.310.pool.telefonica.de. [2a02:3100:ae93:f301:cdd9:d5ea:80d:9131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4866ddbsm25892745e9.7.2026.07.24.15.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 15:22:30 -0700 (PDT)
Date: Sat, 25 Jul 2026 00:22:28 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] serial: amba-pl011: unprepare console clock on
 unregister
Message-ID: <amPlQCleCLARbLpY@gmail.com>
References: <20260724213348.77418-1-kmehltretter@gmail.com>
 <20260724213348.77418-2-kmehltretter@gmail.com>
 <20260724215548.54CAC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724215548.54CAC1F000E9@smtp.kernel.org>

On Fri, Jul 24, 2026 at 09:55:47PM +0100, sashiko-bot@kernel.org wrote:
> [Severity: High]
> Is it possible for uap to be NULL here in pl011_console_exit() within
> drivers/tty/serial/amba-pl011.c?
> 

The root cause is in serial core: serial_core_add_one_port() registers the
console (uart_configure_port()) before the fallible tty_groups allocation,
so a failure there leaves the console registered after the driver has
cleared amba_ports[]. A NULL check in exit() alone would hide one of
several symptom sites and change nothing on the write path.

This is fixed for all console UART drivers by a separate series [1],
"serial: fix console lifetime bugs on failed bind and removal" (1/4 moves
the fallible allocation before console registration); it reproduces this
exact pl011_console_write_thread oops and an i.MX use-after-free. So I'd
keep this series as-is.

[1] https://lore.kernel.org/all/20260719221014.44354-1-kmehltretter@gmail.com/
