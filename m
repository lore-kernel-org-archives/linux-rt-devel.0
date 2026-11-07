Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794043228;
	b=aIfs/7+smVrR/NLvG6XGSwo/huwYF3q/++vcYSVPsrANZcw8wpA0K8PMzocK9HVdeadS
	 R5VmjziZO3znPyMF1hxEcWUOmB/KkpsX9Jv817PVm87ov4938lsVDR3lc2i7OKMOnQ66h
	 LRUDCc5jjx1Q6h+0guJj/7M8th9XUEr/IqYMqs5eahbTWpYOwfoRcoZuItlnGvER93ZtB
	 BJL04H6Z6DGuiNX2ylQLp0ZmcgpLRnpEl/iny8bv202q2VpDdhFmiLZsPDqa9ZTE35Jx2
	 XFaOoGF6VPhRzV1AuknVaGaYJ0PenO0PTKFBk48Q8ygZ1vLfU9aKES7fzy2Je3T03JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794043228;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5OT2GwiO+NQ911Wx05wdbwv6Evhk4ioLeumcb7V7MCY=;
	b=2cIQLefAf6HvD2ctvL19PA3WzahH+3qbno2IkJuj7hXMZRYXw5RRTnA086k08Dewjbfz
	 aEJyrmvhbnitsRh/xWAd4+cu5jD5B3uxB1efQ1WvyFJqfLbM+4ANFxqPl3A0725aNQk+G
	 GttRLHNo9+MrthG0bONvivAbmz4Svw0gjmXc1GilQMh46qnVeVYzGsrSnF9CVmcIzvpqn
	 yVf3LgMKsoXzjqYOXM3JhiIozfKidHm9aP2/QhiDyDZzn2Sh9LL2P1EcmFLlgY/Eqob1Z
	 CYPKd8XZQZz+g0LS0d6CyCe8toQg9BpAMFYOamLBPq2CJJR7Nn5wPccclFn7WuLrW/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VPZNLX2K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B19B606A32E;
	Sat,  7 Nov 2026 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VPZNLX2K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A6A1F0089F;
	Sat,  7 Nov 2026 09:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794043228;
	bh=5OT2GwiO+NQ911Wx05wdbwv6Evhk4ioLeumcb7V7MCY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VPZNLX2KVTazLKj9SJLJ8GBgObEQIDFGOcRLgt60BEhA2SVp4kP26bNuSTk1PsdTL
	 n6+yKxmK4uuUCaHUeRObLB38nJiRQuxe01S9FE3MI/WBhb/SVEhJLLZbhiPJ6vPlpT
	 284C2IZziBdI+6ZtZNO1jR4Uxspm8Hc+9qPvZQ0tS/bER5oMb8qKpaNy/PYyYgw/dX
	 o0Rjtapo5Fc44DSGs+ukV89fCSTtcOH+k6I76qyqASkZa05m1onc22aTSKwllbnq7K
	 0KgHWbiDKbDvaloIQ0QFuM1Y4HKTWBgBoAlCUNE08jWQ09V2LY7K4vEYzyHkNelYah
	 NkF3p4XG5ifHA==
Message-ID: <sashiko-outbox-202759@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 04/10] kconfig: Introduce checkconfig target
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ahmed S. Darwish" <darwi@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Ingo Molnar" <mingo@redhat.com>, "Nathan
 Chancellor" <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>
Cc: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Frederic
 Weisbecker" <frederic@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jonathan
 Corbet" <corbet@lwn.net>, "John Ogness" <john.ogness@linutronix.de>, "Derek
 Barbosa" <debarbos@redhat.com>, =?utf-8?b?WmJpZ25pZXcgSsSZZHJ6ZWpld3Nr?=
 =?utf-8?b?aS1Tem1law==?= <zbyszek@amutable.com>, "Daan De Meyer" <daan.j.demeyer@gmail.com>, "Luca
 Boccassi" <luca.boccassi@gmail.com>, linux-rt-devel@lists.linux.dev, debian-kernel@lists.debian.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261106091922.7560-5-darwi@linutronix.de>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <20261106091922.7560-5-darwi@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 09:20:26 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] kconfig: checkconfig pipeline masks check.py startup and
  dependency errors
--

commit 984ec26ec37b16ca849857bd7d027d488808c4d2
Author: Ahmed S. Darwish <darwi@linutronix.de>

kconfig: Introduce checkconfig target

This commit adds a checkconfig Makefile target that invokes
tools/kconfig-checker/check.py to validate the kernel configuration
against the rules profile specified by RULES, and documents the target in
the help output.

> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index 5baf1c44ffa25..d67a23730259b 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -125,6 +125,26 @@ testconfig: $(obj)/conf
>  	$(if $(findstring 1,$(KBUILD_VERBOSE)),--capture=3Dno)
>  clean-files +=3D tests/.cache
> =20
> +checkconfig :=3D $(PYTHON3) -B $(srctree)/tools/kconfig-checker/check.py
> +list_checkconfig_rules =3D						\
> +	echo -n >&2 "Available RULES: ";				\
> +	$(checkconfig) list-rules >&2;					\
> +	echo >&2
> +
> +PHONY +=3D checkconfig
> +checkconfig:
> +	$(Q)if [ -z "$(RULES)" ]; then					\
> +		echo >&2 "Usage: make RULES=3D<profile> checkconfig";	\
> +		$(list_checkconfig_rules);				\
> +		exit 2;							\
> +	fi
> +	$(Q)if ! $(checkconfig) list-rules | grep -qw "$(RULES)"; then	\
> +		echo >&2 "Unknown RULES profile =3D $(RULES)";		\
> +		$(list_checkconfig_rules);				\
> +		exit 2;							\
> +	fi
> +	$(Q)$(checkconfig) check -r "$(RULES)" -c "$(KCONFIG_CONFIG)"

[Severity: Low]
Does piping $(checkconfig) list-rules into grep mask startup and
dependency failures from check.py?

tools/kconfig-checker/check.py imports jsonschema and yaml at module load
time before handling list-rules:

tools/kconfig-checker/check.py:
    try:
        import jsonschema               # type: ignore
        import yaml as yaml_m           # type: ignore
    except ModuleNotFoundError as e:
        error(f'Missing Python module: {e.name}', os.EX_UNAVAILABLE)

When either module is missing, check.py writes the error to stderr,
produces no stdout, and exits with os.EX_UNAVAILABLE.  Because the POSIX
shell pipeline ignores the exit status of $(checkconfig) list-rules,
grep -qw exits 1 on the empty stdout and the negated condition enters the
branch.  That reports a valid setting such as RULES=3Dpreempt_rt as an
unknown profile and runs $(list_checkconfig_rules), which invokes check.py
a second time and prints a duplicate module error on the same line after
"Available RULES: ".

In addition, grep -qw treats $(RULES) as a regular expression with word
boundaries against the comma-separated output of list-rules rather than
matching an exact profile name, and spawns Python twice on every valid
invocation even though check.py check -r already validates the profile
name.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106091922.7560=
-1-darwi@linutronix.de?part=3D4
