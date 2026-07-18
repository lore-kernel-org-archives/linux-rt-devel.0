Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC5E3537CC;
	Sat, 18 Jul 2026 06:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784356059; cv=none; b=KJOuE+pb88IZBqeNOWbnkhcjCBq6IlBVk35l4Xm2lXDkoO3RMvLJKMHZyJXmAWXwxRRx7iEqDgqM1vKJfW4GFlfpYsmt9eEIDDhWKXhO+SZKBRBR6AqNcnrcgJiJy0KUeWz/L3MhFPC1P+Knl0fPxTZvpYyG45avfnS8dzAPiNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784356059; c=relaxed/simple;
	bh=TBaY03uv07V+L2+hddcCUb9ddbV6ldAqP0RMeRfEvXY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZmOn6GX5Cfq6/W+g8nye4/FZnNDcDp+K5rTXyXSyXBkXj3D++wxUvgl5dppGy8M/jo8UcFT59aRgc6/BDkhpmQ0YyNyPoRDUlr7vNluevTcEVuMm+hNmSC/ymJhS3L5+OcEViuZdvMgE79/OrwyPpu9BzogZYCC+2B6WPgCC0cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jazwIwM1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jazwIwM1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8463C1F00A3D;
	Sat, 18 Jul 2026 06:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784356057;
	bh=vEeFO0va2lFWq9bKMZQt4cz7+Oo/vyoPPJ3X4kDsdug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jazwIwM1e6GEEgGQ3S6o0eCcx0oFgDth3YmSbz981xHkF4eTKohe859zqpMM2l8En
	 RjPzUwRHUUhKPyFypmGZd32zHCga6yp5bofJqZMBq15bMxJ9HbsxUyddwGWekk2cg0
	 M0o0jqAfbsN1kJeblTbcklQ7nkmt/LJRit8CWcnsLFiKM2fnJT3hBXYeE3yXSNblfN
	 lRXc2zHhaORjeibl4YJ/dvZ3gVsJIIbHWrKbGhqrjUeO/ke8Jy7Y4lHfenMWFxNjFR
	 /qE3h4n91D4WV5qlMgVmokxHE6AOh5WJil88X9gsjJkz+JQDztuvq8mHJvOfgYSZ3Q
	 DKNi9p16LxIuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 2/3] af_unix: Do not wait for garbage
 collector in sendmsg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nam Cao" <namcao@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <471af098e92e7171bf828f619ef6b309b97eb618.1784268931.git.namcao@linutronix.de>
References: <cover.1784268931.git.namcao@linutronix.de>
 <471af098e92e7171bf828f619ef6b309b97eb618.1784268931.git.namcao@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 06:27:37 +0000
Message-Id: <20260718062737.8463C1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing `unix_schedule_gc()` from `unix_prepare_fpl()` prevents p=
roactive garbage collection of cyclic AF_UNIX FDs.
--

--- Patch [2]: [PATCH net-next v2 2/3] af_unix: Do not wait for garbage col=
lector in sendmsg() ---
commit beb11f61735b0b337472eab3fcd9041c544b30de
Author: Nam Cao <namcao@linutronix.de>

af_unix: Do not wait for garbage collector in sendmsg()

This commit removes the unix_schedule_gc() call from unix_prepare_fpl()
during sendmsg(). The patch notes that previous soft lockup and OOM issues
are already mitigated by async garbage collection and RLIMIT_NOFILE checks.

> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 0783555e25266..f180c59b3da9d 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -300,8 +300,6 @@ int unix_prepare_fpl(struct scm_fp_list *fpl)
>  	if (!fpl->edges)
>  		goto err;
> =20
> -	unix_schedule_gc(fpl->user);
> -
>  	return 0;
> =20
>  err:

[Severity: High]
Does removing the unix_schedule_gc() call from unix_prepare_fpl() prevent
proactive garbage collection of cyclic AF_UNIX file descriptors?

If a long-running application creates a cycle of AF_UNIX sockets and closes
its own file descriptors to them, the cycle maintains a positive f_count.
Without this call triggering the garbage collector, the uncollected cyclic
sockets could accumulate until the application reaches its RLIMIT_NOFILE
quota, causing subsequent socket operations to fail.

Additionally, does this change leave the user parameter logic in
unix_schedule_gc() as dead code?

If the remaining callers now only pass NULL, the user quota checks in
unix_schedule_gc() will no longer be reachable:

net/unix/garbage.c:unix_schedule_gc() {
	...
	if (user &&
	    READ_ONCE(user->unix_inflight) < UNIX_INFLIGHT_SANE_USER)
		return;
	...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784268931.gi=
t.namcao@linutronix.de?part=3D2
