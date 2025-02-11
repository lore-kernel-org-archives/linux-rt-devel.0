Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118A1253B52
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Feb 2025 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739288995; cv=none; b=foAjn7DiMf9V5HZon87+hJHohDyGFwbuKvdjUauA+5pg6BqGsu5D+lSp0SmX7aKHXvdPyJGbRyAHKZApL0YRv8QIKKj3K2awxLHqUfG9PWnE47EMuGJAdph1x+rn34wXlAOljGHv+JXv2yxsbLjE7Xsn24LPd58ITjF3C08PlGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739288995; c=relaxed/simple;
	bh=9kgt4DsYnmqFCPg4peB6p4/cEoV7Wc11pP7aFn7Ru+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fj74yxKs3l3o8vyDYWOUv4DJmPGeBvKYqLEqOpfl5BtrDsjfBzTDcqeaV6fwmGtR50Iu3mZ6oc9S7knuzLlQB9om0T21fhX2RiiaHuY9Xmu0gyA7bKjp2lwccEBbL2F1pAAseAs/fJuXSxmEZm0DUJJAJrPyBmo1f8/Y8QNfHQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RE7BAAlA; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RE7BAAlA"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de399ee527so7308a12.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 11 Feb 2025 07:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739288991; x=1739893791; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kgt4DsYnmqFCPg4peB6p4/cEoV7Wc11pP7aFn7Ru+s=;
        b=RE7BAAlAQmC9fJAflSDAv2QzLgxxAZZXGBLCQPhXdRBxRTQx6WwC0qj0/DY3bm26Bn
         Pk58pX33OMYmSe+Lg4ZODcKf88ZhkvJr6g+GebePzZfWyUeFBxo5ypZBE+QvPn8reJtw
         fD9vhJmU2jWd6VemjC9gcd1y/oZSBO09jypp49MPtrspH23CAyJS5p+YdE2sLy+qs+1S
         R+oVYL8hAtYPKAdsmVnZqZeWrKFIxAF2UKtaZOSs2MNmTUqzB7f9gkyR06yAlOX3X/yN
         0q8WYM4M3AWmRKzHNgxESFq6HMf3JS+cOwQFTtuvYtZLp4nRlIYumP5WXYucoqJBabqD
         aA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739288991; x=1739893791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kgt4DsYnmqFCPg4peB6p4/cEoV7Wc11pP7aFn7Ru+s=;
        b=I6EkDOPMiHvTvF3XihJDuFqFTpTLLIrbTH6ZNPOBFUykQPXG667iASOTxLEdfYYbng
         BsnHnOrT4ug+UszPRLtpPr8524c71yT8vFONxzM7CwqrfHETiHYaYITmITeDwkJPjc8g
         Iqwzu8MwKDUHp5qYCxmjfpzLPZbYfPJMJlcZdGxU790KrThmD8dPZ9i9Pv3KiGl9yC/1
         yavmSTrb2SDOm2gxuzzcdLgK23I6IDFHxuG/qIQRPJqkNvqbudEeA9oSA3ePniLI0MLs
         0rED5Sbj1GSo9FBPriy5AL7ssr2a3Ozl+bzrG/VSa+sfJW3V7aZUDwI9fe+XlesOOLdn
         wL6g==
X-Forwarded-Encrypted: i=1; AJvYcCXR3T0aaNqW+4FPjz0D7cRhKLSWP2n5n7haPeJtU4hdGerQZvTzEOXrqx7j5Ek0hbIfMqBnQ2tBdJvGJXzDMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdF3Y32GhrF3da4u+tsPdXTd0KmUSnIOylt+928PZma7Q+iDrg
	6I7iZRvaRWd0qqG4wUa9UUp+yo3uqfdOpJxVd1qYShUYTIdd9wuo10zuouaHwU2c79Xwx2u0SVI
	hAbONNExczRaTQnWkDduyFgrR71ovl/BbDsVI
X-Gm-Gg: ASbGncv4bL6G65GAzPKJtBM5sgMLS0olq+ONA0yi0NetcIxwfecu0Sas6hwEIViRDeR
	l2CMAThZgDdX2Jq2efq58GP6Lat5kQCP7rYGmH49vS6loveZjD5o6vupXIJT+qE3sd3ZraY7zQC
	TGJLqofinkCIA0zovpgTFgFIlx/98Wvaw=
X-Google-Smtp-Source: AGHT+IE4Fxxf+5z69pFOeL1vlS+GzV7UVLD5EIil0y2c6civPDnAyqFQUMiM+rBmwqzz2VihxIer5GQ59MHN5QmVrIQ=
X-Received: by 2002:a50:9314:0:b0:5db:e72d:b084 with SMTP id
 4fb4d7f45d1cf-5de9cce8feemr101816a12.0.1739288991143; Tue, 11 Feb 2025
 07:49:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250211090511.xeFJVnH_@linutronix.de> <CABXOdTeLUi8mKkV38SegM_n8=Uyykd-X+n7RysjpgAZfxxb5BQ@mail.gmail.com>
 <20250211153759.5sSPp1PI@linutronix.de>
In-Reply-To: <20250211153759.5sSPp1PI@linutronix.de>
From: Guenter Roeck <groeck@google.com>
Date: Tue, 11 Feb 2025 07:49:40 -0800
X-Gm-Features: AWEUYZlEqu__1t_B87cyFxYGHoCRQ18AdYIcVNJRtnSUfqO1snO9huHuOzykOU4
Message-ID: <CABXOdTdgKPZEOWRE11V7XRpRwgAL5bav_X+ibGbYyJwj1EnLsQ@mail.gmail.com>
Subject: Re: PREEMPT_RT testing on kernelci
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: kernelci@lists.linux.dev, linux-rt-devel@lists.linux.dev, 
	stable-rt@vger.kernel.org, Daniel Wagner <wagi@monom.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 7:38=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-02-11 07:33:57 [-0800], Guenter Roeck wrote:
> > Unrelated to KernelCI - how stable is PREEMPT_RT in practice ? Reason
> > for asking is that I enabled it for x86_64 together with lock
> > debugging and got an almost immediate "sleeping function called"
> > backtrace.
>
> If I would have seen it I would have acted. My guess is that this is
> something not a lot of people observed.
>

I suspect that not many run the code with lock debugging enabled. I'll
send you the backtrace separately.

Guenter

> > Thanks,
> > Guenter
>
> Sebastian
